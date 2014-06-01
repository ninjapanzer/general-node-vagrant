#!/usr/bin/env bash

mkdir /home/vagrant/tmp
sudo apt-get -y install python-software-properties
sudo add-apt-repository -y ppa:chris-lea/node.js
sudo apt-get update
sudo apt-get -y install nodejs
git clone git@github.com:thinkthroughmath/lesson-player.git
cd lesson-player
sudo npm install -g grunt grunt-cli bower
npm install
bundle install
bower install
