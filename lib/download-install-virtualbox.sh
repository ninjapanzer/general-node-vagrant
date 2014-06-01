#!/usr/bin/env bash

virtualbox_dmg=VirtualBox-4.3.2-90405-OSX.dmg
original_dir=`pwd`
mkdir -p tmp
cd tmp

echo "----------- Installing VirtualBox ------------"

if [ ! -e "$virtualbox_dmg" ];
then
    wget http://download.virtualbox.org/virtualbox/4.3.2/$virtualbox_dmg
fi

hdiutil attach $virtualbox_dmg
sleep 5 # needed for pause until mount happens
cd /Volumes/VirtualBox
sudo installer -pkg VirtualBox.pkg -target /
echo "------------- Finished installing VirtualBox  ------------"
cd $original_dir
hdiutil detach /Volumes/VirtualBox/
