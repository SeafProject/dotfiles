#!/bin/bash -xv
#
# Install Postfix Admin
#
tmp=/tmp/tmp-$$

DIR=/opt/postfixAdmin
VERSION=2.91

# DB設定
DB_ROOT_USER=root
DB_ROOT_PASS=deganjue
DB_USER=postfix
DB_PASS=postfixdeganjue
DB_HOST=127.0.0.1
DB_NAME=postfix

# ADMIN設定
ADMIN_SITE_OWNER=hajime@avap.co.jp
ADMIN_SETUP_PASSWORD=e5b54a6b753483f0e980dc6ff8d20a6d:635f2e9189b63b5947def28cbef3fc58018b4d74

# Postfix Admin
POSTFIX_ADMIN_URL='http://downloads.sourceforge.net/project/postfixadmin/postfixadmin/postfixadmin-2.91/postfixadmin-2.91.tar.gz?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fpostfixadmin%2F&ts=1412424519&use_mirror=jaist'

if [ ! -d $DIR ]
then
	curl -sSL $POSTFIX_ADMIN_URL | tar zxvf - -C /tmp
	sudo mv /tmp/postfixadmin-$VERSION $DIR
fi

# DATABASEを設定する
cat <<SQL | tee | mysql -u$DB_ROOT_USER -p$DB_ROOT_PASS
CREATE DATABASE IF NOT EXISTS ${DB_NAME};
DROP USER '${DB_USER}'@'localhost';
CREATE USER '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASS}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'localhost';
SQL

# ローカルな設定をする
cat <<EOF | sudo tee $DIR/config.local.php > /dev/null
<?php
\$CONF['default_language'] = 'ja';
\$CONF['database_type'] = 'mysql';
\$CONF['database_host'] = '${DB_HOST}';
\$CONF['database_user'] = '${DB_USER}';
\$CONF['database_password'] = '${DB_PASS}';
\$CONF['database_name'] = '${DB_NAME}';
\$CONF['admin_email'] = '${ADMIN_SITE_OWNER}';
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


# Web設定をする
sudo chown -R www-data:www-data $DIR
sudo ln -s $DIR /var/www/html/postfixAdmin
sudo chmod 640 $DIR/*.php
sudo chmod 640 $DIR/images/*.png
sudo chmod 640 $DIR/languages/*.lang
sudo chmod 640 $DIR/users/*.php

#
# PostfFIXの設定をMYSQLで行うための設定ファイルを吐き出す
#
cat <<EOF | sudo tee /etc/postfix/mysql_virtual_alias_maps.cf > /dev/null
user         = ${DB_USER}
password     = ${DB_PASS}
hosts        = ${DB_HOST}
dbname       = ${DB_NAME}
table        = alias
select_field = goto
where_field  = address
EOF

cat <<EOF | sudo tee /etc/postfix/mysql_virtual_domains_maps.cf > /dev/null
user         = ${DB_USER}
password     = ${DB_PASS}
hosts        = ${DB_HOST}
dbname       = ${DB_NAME}
table        = domain
select_field = domain
where_field  = domain
additional_conditions = and active = '1'
EOF

cat <<EOF | sudo tee /etc/postfix/mysql_virtual_mailbox_maps.cf > /dev/null
user         = ${DB_USER}
password     = ${DB_PASS}
hosts        = ${DB_HOST}
dbname       = ${DB_NAME}
table        = mailbox
select_field = maildir
where_field  = username
EOF


cat <<EOF | sudo tee /etc/postfix/mysql_virtual_mailbox_limit_maps.cf > /dev/null
user         = ${DB_USER}
password     = ${DB_PASS}
hosts        = ${DB_HOST}
dbname       = ${DB_NAME}
query        = SELECT quota FROM mailbox WHERE username='%s' AND active = '1'
EOF
