#
# INSTALL PHP
#

# GET SOUCE
PHP_VERSION='5.5.17'
PHP_SOURCE_URL="http://jp1.php.net/get/php-$PHP_VERSION.tar.gz/from/this/mirror"

# Build All Dependency
#sudo add-apt-repository ppa:ondrej/php5
#sudo apt-get update
sudo apt-get install apache2
sudo apt-get install dovecot-dev
sudo apt-get build-dep php5
sudo apt-get install libc-client2007e-dev libmcrypt-dev
sudo apt-get install libsqlite-dev sqlite

#
# IMAP対策
#
[ -d /usr/lib64 ] || sudo mkdir /usr/lib64
[ -f /usr/lib64/libc-client.a ] || sudo ln -s /usr/lib/libc-client.a /usr/lib64/libc-client.a
[ -f /usr/lib64/libssl.a ] || sudo ln -s /usr/lib/x86_64-linux-gnu/libssl.a /usr/lib64/libssl.a


cd /usr/local/src
if [ ! -d 'php-'$PHP_VERSION ]
then
	curl -sSL $PHP_SOURCE_URL | tar -zxvf -
fi

cd php-$PHP_VERSION

OPTIONS="$OPTIONS --prefix=/opt/php"
OPTIONS="$OPTIONS --exec-prefix=/opt/php"

# Basic
OPTIONS="$OPTIONS --with-apxs2=/usr/bin/apxs2"
OPTIONS="$OPTIONS --with-pear"
#OPTIONS="$OPTIONS --with-libdir=/lib/x86_64-linux-gnu"
OPTIONS="$OPTIONS --with-libdir=lib64"
OPTIONS="$OPTIONS --with-config-file-path=/opt/php/etc"
OPTIONS="$OPTIONS --with-config-file-scan-dir=/opt/php/etc/conf.d"

# ZIP
OPTIONS="$OPTIONS --enable-zip"

# For Databases
OPTIONS="$OPTIONS --with-mysql"
OPTIONS="$OPTIONS --with-mysqli"
OPTIONS="$OPTIONS --with-pgsql=/usr"
OPTIONS="$OPTIONS --with-pdo-pgsql=/usr"
OPTIONS="$OPTIONS --with-pdo-mysql=mysqlnd"

# Curl
OPTIONS="$OPTIONS --with-curl=/usr/bin"

# SSL
OPTIONS="$OPTIONS --with-openssl-dir=/usr"
OPTIONS="$OPTIONS --with-openssl"

# Font
OPTIONS="$OPTIONS --with-freetype-dir=/usr"

# Multibyte
OPTIONS="$OPTIONS --enable-mbstring"

# Pcntl
OPTIONS="$OPTIONS --enable-pcntl"

# Image
OPTIONS="$OPTIONS --with-gd"
OPTIONS="$OPTIONS --with-jpeg-dir=/usr"
OPTIONS="$OPTIONS --with-png-dir=/usr"
OPTIONS="$OPTIONS --enable-gd-native-ttf"

# Encrypt
OPTIONS="$OPTIONS --with-mcrypt=/usr"

# Imap
OPTIONS="$OPTIONS --with-kerberos"
OPTIONS="$OPTIONS --with-imap=/usr"
OPTIONS="$OPTIONS --with-imap-ssl"

# FPM
OPTIONS="$OPTIONS --enable-fpm"
OPTIONS="$OPTIONS --with-fpm-user=www-data"
OPTIONS="$OPTIONS --with-fpm-group=www-data"

# Regex
OPTIONS="$OPTIONS --enable-mbregex"
OPTIONS="$OPTIONS --with-pcre-regex"

# For Using Interactive Shell Mode
OPTIONS="$OPTIONS --with-readline"

# For Multi Threds
OPTIONS="$OPTIONS --with-tsm-pthreads"
OPTIONS="$OPTIONS --enable-maintainer-zts"

# For RoundCubeMail
OPTIONS="$OPTIONS --enable-intl=shared"
OPTIONS="$OPTIONS --enable-exif"

# For SQLITE
OPTIONS="$OPTIONS --with-pdo-sqlite"
OPTIONS="$OPTIONS --with-sqlite3"


./configure $OPTIONS || exit 1
make clean
make                 || exit 1
make test            || exit 1
sudo make install    || exit 1
