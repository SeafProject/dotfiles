#!/bin/bash -xv

HOME=$(cd $(dirname $0)/../..;pwd)
DIR=$(dirname $0)

# Installing RVM

# For Single
# [ -d ~/.rvm ] || curl -sSL http://get.rvm.io | bash -s stable --ruby=1.9.3

# For Multi
[ -d /usr/local/rvm ] || curl -sSL http://get.rvm.io | sudo bash -s stable --ruby=1.9.3

[ -f /usr/local/rvm/scripts/rvm ] && source /usr/local/rvm/scripts/rvm

rvm list known
