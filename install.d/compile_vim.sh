VIM_REPOS="https://vim.googlecode.com/hg/ vim"

sudo apt-get install \
	ctags \
	mercurial \
	lua5.2 liblua5.2 liblua5.2-dev \
	liblua5.1-dev \
	libperl-dev \
	python3 \
	python-dev \
	libpython3-dev \
	libtool-doc autoconf automake gcj-jdk \
	autotools-dev libltdl-dev libltdl7 \
	libreadline-dev libreadline6-dev libtinfo-dev libtool pkg-config


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
			--enable-pythoninterp \
			--enable-fail-if-missing

		[ $? -ne 0 ] && exit $?
		sudo make
		sudo make install
	popd
popd

echo "Vim To Add Alternatives As Default Editor"
echo "update-alternatives --install /usr/bin/editor editor /usr/local/bin/vim 100"

