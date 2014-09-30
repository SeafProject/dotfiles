#!/bin/bash -xv

HOME=$(cd $(dirname $0)/../../..;pwd)
DIR=$(cd $(dirname $0)/../..;pwd)
NEOBUNDLE_REPOS=https://github.com/Shougo/neobundle.vim
VIM_REPOS="https://vim.googlecode.com/hg/ vim"

[ -d "$HOME/.vim" ] || mkdir -v $HOME/.vim
[ -d "$HOME/.vim/bundle" ] || mkdir -v $HOME/.vim/bundle

[ -d "$HOME/.vim/bundle/neobundle.vim" ] || git clone $NEOBUNDLE_REPOS $HOME/.vim/bundle/neobundle.vim

[ -f "$HOME/.vimrc" ] || ln -s "$DIR/_vimrc" "$HOME/.vimrc"

ctags --version > /dev/null || $DIR/setup.d/ctags.sh

vim --version | grep +lua > /dev/null

if [ $? -ne 0 ]
then
	sudo apt-get install \
		mercurial \
		lua5.2 liblua5.2 liblua5.2-dev \
		liblua5.1-dev \
		libperl-dev \
		python3 \
		libpython3-dev \
		libtool-doc autoconf automake gcj-jdk \
		autotools-dev libltdl-dev libltdl7 \
		libreadline-dev libreadline6-dev libtinfo-dev libtool pkg-config


	if [ -f /usr/local/bin/vim ]
	then
		pushd /usr/local/src
			sudo hg clone $VIM_REPOS
			pushd vim/src
				sudo ./configure \
					--with-features=huge \
					--enable-multibyte \
					--prefix=/usr/local \
					--enable-gui=gnome2 \
					--enable-luainterp=yes \
					--with-compiledby="Hajime MATSUMOTO <mail@hazime.org>" \
					--enable-fail-if-missing

				[ $? -ne 0 ] && exit $?
				sudo make
				sudo make install
			popd
		popd

		sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/vim 100
	fi
fi


/usr/local/bin/vim +NeoBundleInstall +q
