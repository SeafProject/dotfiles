# Install PHP APC
DIR=/opt/php

# PHP5 OPcache
#sudo /opt/php/bin/pecl install ZendOpcache
sudo $DIR/bin/pecl install channel://pecl.php.net/ZendOpcache-7.0.3

# zend_extension=/opt/php/lib/php/extensions/no-debug-zts-20121212/opcache.so

FILE=$(find $DIR/lib/php | sed -n -e '/debug-zts.*opcache.so/p')

cat <<EOF | sudo tee $DIR/etc/conf.d/opcache.ini
zend_extension=$FILE

[opcache]
opcache.enable=1
opcache.enable_cli=1
opcache.memory_consumption=128
opcache.interned_strings_buffer=8
opcache.max_accelerated_files=4000
opcache.revalidate_freq=60
opcache.fast_shutdown=1
EOF

php -i | grep opcache
php -v

