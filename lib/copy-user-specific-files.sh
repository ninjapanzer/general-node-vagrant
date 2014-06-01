#!/usr/bin/env bash

# copies user specific files from host machine onto guest machine
# intended to be run from the host machine

mkdir -p tmp # ugh

source ./env

echo Copying GITHUB_PRIVATE_KEY $GITHUB_PRIVATE_KEY to vm...
echo running cp $GITHUB_PRIVATE_KEY tmp/github_private_key
cp $GITHUB_PRIVATE_KEY tmp/github_private_key

sleep 5

/usr/bin/vagrant ssh -c 'cp /vagrant/tmp/github_private_key ~/.ssh/id_rsa'
