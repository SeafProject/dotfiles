#!/bin/bash -xv

HOME=$(cd $(dirname $0)/../../..;pwd)
DIR=$(cd $(dirname $0)/../..;pwd)

# Instal Zshrc

if [ -f "$HOME/.zshrc" ] 
then
	echo "Skip For .zshrc (File Exists)"
else
	ln -s "$DIR/_zshrc.sh" "$HOME/.zshrc"
fi
