#
# TMUX インストーラ
#

sudo apt-get install python-pip tmux

pip -V > /dev/null

if [ $? -ne 0 ]
then
	sudo su -c 'pip list' | grep powerline-status > /dev/null
	sudo pip install -U pip
fi

powerline -h > /dev/null
if [ $? -ne 0 ]
then
	sudo su -c 'pip install --user git+git://github.com/Lokaltog/powerline'
fi

PowerlineSymbols="https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf"
PowerlineSymbolsConf="https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf"

if [ ! -e /usr/share/doc/PowerlineSymbols.otf ]
then
	sudo wget $PowerlineSymbols -O /usr/share/doc/PowerlineSymbols.otf
	sudo fc-cache -vf
fi

if [ ! -e /etc/fonts/conf.d/10-powerline-symbols.conf ]
then
	sudo wget $PowerlineSymbolsConf -O /etc/fonts/conf.d/10-powerline-symbols.conf
fi
