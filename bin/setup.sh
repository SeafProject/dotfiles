#!/bin/bash -xv

HOME=$(cd $(dirname $0)/../..;pwd)
DIR=$(dirname $0)

# Instal Zshell Files
bash $DIR/setup.d/zsh.sh
bash $DIR/setup.d/vim.sh
