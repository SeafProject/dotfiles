#!/bin/bash -xv

HOME=$(cd $(dirname $0)/../..;pwd)
DIR=$(dirname $0)

NVM_DIR=/usr/local/nvm
NPM_CONFIG_PREFIX=/usr/local/node

# Installing NVM
[ -d /opt ] || sudo mkdir /opt
cd /opt

[ -d /opt/nvm ]           || sudo git clone git://github.com/creationix/nvm.git /opt/nvm
[ -d $NVM_DIR ]           || sudo mkdir $NVM_DIR
[ -d $NPM_CONFIG_PREFIX ] || sudo mkdir $NPM_CONFIG_PREFIX

[ -f /etc/profile.d/nvm.sh ] || cat  <<FILE | sudo tee /etc/profile.d/nvm.sh
#
# NVM profile
#
# /etc/profile.d/nvm.sh # sh extension required for loading.
#
export NVM_DIR=$NVM_DIR
source /opt/nvm/nvm.sh
export NPM_CONFIG_PREFIX=$NVM_DIR
export PATH=$NVM_DIR/bin:$PATH
FILE
