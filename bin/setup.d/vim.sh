#!/bin/bash -xv

HOME=$(cd $(dirname $0)/../../..;pwd)
DIR=$(cd $(dirname $0)/../..;pwd)
NEOBUNDLE_REPOS=https://github.com/Shougo/neobundle.vim
VIM_REPOS="https://vim.googlecode.com/hg/ vim"

[ -d "$HOME/.vim" ] || mkdir -v $HOME/.vim
[ -d "$HOME/.vim/tmp" ] || mkdir -v $HOME/.vim/tmp
[ -d "$HOME/.vim/bundle" ] || mkdir -v $HOME/.vim/bundle
[ -d "$HOME/.vim/bundle/neobundle.vim" ] || git clone $NEOBUNDLE_REPOS $HOME/.vim/bundle/neobundle.vim

rm -rf $HOME/.vimrc*

ln -s "$DIR/vimrc.d/_vimrc" "$HOME/.vimrc"
ln -s "$DIR/vimrc.d/_vimrc.basic" "$HOME/.vimrc.basic"
ln -s "$DIR/vimrc.d/_vimrc.keybind" "$HOME/.vimrc.keybind"
ln -s "$DIR/vimrc.d/_vimrc.neoBundle" "$HOME/.vimrc.neoBundle"
ln -s "$DIR/vimrc.d/_vimrc.neoComplete" "$HOME/.vimrc.neoComplete"
ln -s "$DIR/vimrc.d/_vimrc.dwm" "$HOME/.vimrc.dwm"
ln -s "$DIR/vimrc.d/_vimrc.unite" "$HOME/.vimrc.unite"
ln -s "$DIR/vimrc.d/_vimrc.look_and_feel" "$HOME/.vimrc.look_and_feel"
ln -s "$DIR/vimrc.d/_vimrc.powerline" "$HOME/.vimrc.powerline"

if [ ! -e $HOME/.vimrc.local ]
then
	touch $HOME/.vimrc.local
fi

# Python Package Installer
sudo apt-get install python-pip

pip -V > /dev/null
if [ $? -ne 0 ]
then
	sudo su -c 'pip list' | grep powerline-status > /dev/null
	sudo pip install -U pip
fi

# Install Powerline
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

/usr/local/bin/vim +NeoBundleInstall +q
