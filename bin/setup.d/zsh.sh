#!/bin/bash -xv

HOME=$(cd $(dirname $0)/../../..;pwd)
DIR=$(cd $(dirname $0)/../..;pwd)

# Instal Zshrc

[ -f "$HOME/.zshrc" ]               || ln -s "$DIR/_zshrc.sh" "$HOME/.zshrc"
[ -f "$HOME/.zprofile" ]            || ln -s "$DIR/_zprofile.sh" "$HOME/.zprofile"
[ -d "$HOME/.zsh/local" ]           || mkdir -p $HOME/.zsh/local
[ -f "$HOME/.zsh/local/.zshrc" ]    || touch $HOME/.zsh/local/.zshrc
[ -f "$HOME/.zsh/local/.zprofile" ] || touch $HOME/.zsh/local/.zprofile
