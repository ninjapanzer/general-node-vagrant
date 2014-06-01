#!/usr/bin/env bash

vagrant_dmg=Vagrant-1.3.5.dmg
original_dir=`pwd`
mkdir -p tmp
cd tmp

if [ ! -e "$vagrant_dmg" ];
then
    wget http://files.vagrantup.com/packages/a40522f5fabccb9ddabad03d836e120ff5d14093/$vagrant_dmg
fi

hdiutil attach $vagrant_dmg
sleep 5 # needed for pause until mount happens
cd /Volumes/Vagrant
echo "---------- Installing vagrant ------------- "
sudo installer -pkg Vagrant.pkg -target /
echo "----------- Finished installing vagrant ----------"
hdiutil detach /Volumes/Vagrant
cd $original_dir
