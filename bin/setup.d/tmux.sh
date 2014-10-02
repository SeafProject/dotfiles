#!/bin/bash -xv

HOME=$(cd $(dirname $0)/../../..;pwd)
DIR=$(cd $(dirname $0)/../..;pwd)

# Instal Zshrc

[ -f "$HOME/.tmux.conf" ] || ln -s "$DIR/_tmux.conf" "$HOME/.tmux.conf"
