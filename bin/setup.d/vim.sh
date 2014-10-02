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

if [ ! -e $HOME/.vimrc.local ]
then
	touch $HOME/.vimrc.local
fi


/usr/local/bin/vim +NeoBundleInstall +q
