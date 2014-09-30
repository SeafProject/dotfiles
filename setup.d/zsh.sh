#!/bin/bash -xv

HOME=$(cd $(dirname $0)/../..;pwd)
DIR=$(cd $(dirname $0)/..;pwd)

# Instal Zshrc
ln -s "$DIR/_zshrc.sh" "$HOME/.zshrc"
