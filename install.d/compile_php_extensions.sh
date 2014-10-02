#
# Pecl XDEBUG
#
DIR=$(cd $(dirname $0)/../../; pwd)
tmp=/tmp/tmp-$$
PHP=/opt/php/bin/php
PECL=/opt/php/bin/pecl
MODULE_DIR=/opt/php/etc/conf.d/

echo ">>>> XDEBUG";
$PHP -r 'phpinfo();' | grep xdebug > /dev/null

if [ $? -ne 0 ]
then
echo ">>>> Start Install XDEBUG";
sudo $PECL install xdebug
cat <<EOF | sudo tee $MODULE_DIR/xdebug.ini
; configuration for php Xdebug module
; priority=20
zend_extension=/opt/php/lib/php/extensions/no-debug-non-zts-20121212/xdebug.so
EOF

echo ">>>> .... Installed";
fi

echo ">>>> YAML";
$PHP -r 'phpinfo();' | grep yaml > /dev/null

if [ $? -ne 0 ]
then
echo ">>>> Start Install YAML";
sudo $PECL install yaml
cat <<EOF | sudo tee $MODULE_DIR/yaml.ini
; configuration for php Yaml module
; priority=20
extension=yaml.so
EOF

echo ">>>> .... Installed";
fi
