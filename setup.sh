#!/bin/bash -xv

HOME=$(cd $(dirname $0)/..;pwd)
DIR=$(dirname $0)

# Instal Zshell Files
bash ./setup.d/zsh.sh
