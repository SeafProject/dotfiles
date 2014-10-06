#!/bin/bash -xv
#
# Install Postfix
#
tmp=/tmp/tmp-$$
sudo apt-get install postfix mysql-server dovecot-mysql dovecot-imapd

sudo cat /etc/group | grep vmail > /dev/null
if [ $? -ne 0 ]
then
	sudo groupadd -g 40000 vmail
	sudo useradd -g 40000 -u 40000 vmail
fi

id vmail

VMAIL=vmail
DB_USER=postfix
DB_PASS=postfixdeganjue
DB_HOST=localhost
DB_NAME=postfix
ADMIN_SITE_OWNER=hajime@avap.co.jp
ADMIN_SETUP_PASSWORD=deganjue

# About MYSQL
cat <<EOF | sudo tee /etc/postfix/mysql_virtual_alias_maps.cf > /dev/null
user         = $DB_USER
password     = $DB_PASS
hosts        = $DB_HOST
dbname       = $DB_NAME
table        = alias
select_field = goto
where_field  = address
EOF

cat <<EOF | sudo tee /etc/postfix/mysql_virtual_domains_maps.cf > /dev/null
user         = $DB_USER
password     = $DB_PASS
hosts        = $DB_HOST
dbname       = $DB_NAME
table        = domain
select_field = domain
where_field  = domain
additional_conditions = and active = '1'
EOF

cat <<EOF | sudo tee /etc/postfix/mysql_virtual_mailbox_maps.cf > /dev/null
user         = $DB_USER
password     = $DB_PASS
hosts        = $DB_HOST
dbname       = $DB_NAME
table        = mailbox
select_field = maildir
where_field  = username
EOF


cat <<EOF | sudo tee /etc/postfix/mysql_virtual_mailbox_limit_maps.cf > /dev/null
user         = $DB_USER
password     = $DB_PASS
hosts        = $DB_HOST
dbname       = $DB_NAME
query        = SELECT quota FROM mailbox WHERE username='%s' AND active = '1'
EOF

# Postfix Admin
POSTFIX_ADMIN_URL='http://downloads.sourceforge.net/project/postfixadmin/postfixadmin/postfixadmin-2.91/postfixadmin-2.91.tar.gz?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fpostfixadmin%2F&ts=1412424519&use_mirror=jaist'

pushd /usr/local/src
curl -sSL $POSTFIX_ADMIN_URL | tar zxvf -
pushd postfixadmin*

cat <<EOF | tee config.local.php
<?php
\$CONF['configured'] = true;
\$CONF['setup_password'] = '$ADMIN_SETUP_PASSWORD';
\$CONF['default_language'] = 'ja';
\$CONF['database_type'] = 'mysql';
\$CONF['database_host'] = '$DB_HOST';
\$CONF['database_user'] = '$DB_USER';
\$CONF['database_password'] = '$DB_PASS';
\$CONF['database_name'] = '$DB_NAME';
\$CONF['admin_email'] = '$ADMIN_SITE_OWNER';
\$CONF['alias_domain'] = 'NO';
\$CONF['dovecotpw'] = "/usr/bin/doveadm pw";
\$CONF['show_password'] = 'YES';
\$CONF['show_footer_text'] = 'NO';
 
\$CONF['emailcheck_resolve_domain']='NO';
\$CONF['create_mailbox_subdirs_prefix']='';
 
\$CONF['new_quota_table'] = 'YES';
\$CONF['quota'] = 'YES';
 
\$CONF['aliases'] = '0';
\$CONF['mailboxes'] = '0';
\$CONF['maxquota'] = '0';
 
\$CONF['domain_path'] = 'YES';
\$CONF['domain_in_mailbox'] = 'NO';
 
\$CONF['encrypt'] = 'md5crypt';
 
\$CONF['user_footer_link'] = "http://localhost/postfixAdmin/users/main.php";
 
?>
EOF

popd
popd

cat <<SQL | mysql -uroot -pdeganjue
CREATE DATABASE postfix;
CREATE USER 'postfix'@'localhost' IDENTIFIED BY 'postfixdeganjue';
GRANT ALL PRIVILEGES ON \`postfix\` . * TO 'postfix'@'localhost';
SQL

#cat /etc/dovecot/dovecot.conf | sed -e '$s/^!//' > $tmp-dovecot.conf
#if [ ! -f /etc/dovecot/dovecot.conf.orig ]
#then
#	sudo cp /etc/dovecot/dovecot.conf /etc/dovecot/dovecot.conf.orig
#fi
#sudo mv $tmp-dovecot.conf /etc/dovecot/dovecot.conf


cat <<EOF | sudo tee /etc/dovecot/local.conf > /dev/null
# debug関係
auth_debug_passwords = yes
auth_verbose = no
auth_debug = yes

listen = *
disable_plaintext_auth = no
auth_mechanisms = PLAIN LOGIN CRAM-MD5
mail_location = maildir:/home/$VMAIL/%d/%n
first_valid_uid = 10000
first_valid_gid = 10000
mail_plugins = quota

protocol imap {
	imap_client_workarounds = delay-newmail tb-extra-mailbox-sep
	mail_plugins = \$mail_plugins imap_quota
}
protocol pop3 {
	pop3_client_workarounds = outlook-no-nuls oe-ns-eoh
}
passdb {
	driver = sql
	args = /etc/dovecot/dovecot-postfixadmin-mysql.conf
}
userdb {
	driver = sql
	args = /etc/dovecot/dovecot-postfixadmin-mysql.conf
}
service auth {
	unix_listener /var/spool/postfix/private/auth {
		mode = 0666
	}
}
plugin {
	quota = maildir:User quota
}
EOF


cat /etc/dovecot/conf.d/10-auth.conf | sed  \
	-e '/^auth_mechanisms/s/^/#/' \
	-e '/^include auth-system/s/^/#/'|\
cat - > $tmp-auth.conf
if [ ! -f /etc/dovecot/conf.d/10-auth.conf.orig ]
then
	sudo cp /etc/dovecot/conf.d/10-auth.conf /etc/dovecot/conf.d/10-auth.conf.orig
fi
sudo mv $tmp-auth.conf /etc/dovecot/conf.d/10-auth.conf


cat <<EOF | sudo tee /etc/dovecot/dovecot-postfixadmin-mysql.conf > /dev/null
driver = mysql
connect = host=$DB_HOST dbname=$DB_NAME user=$DB_USER password=$DB_PASS
default_pass_scheme = MD5-CRYPT
password_query = SELECT password FROM mailbox WHERE username = '%u' AND active = '1'
user_query = SELECT concat('/home/$VMAIL/', maildir) AS home, 10000 AS uid,
 10000 AS gid FROM mailbox WHERE username = '%u' AND active = '1'
EOF

dovecot -n
