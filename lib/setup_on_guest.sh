#!/usr/bin/env bash

source /vagrant/env

echo setup_on_guest.sh: configuring postgresql
sudo lib/config-postgres.sh

echo setup_on_guest.sh: installing rvm and rubies
lib/install-rvm.sh

echo setup_on_guest.sh: creating a clone of apangea
lib/clone-apangea-in-guest.sh

echo setup_on_guest.sh: setting up apangea for use
lib/setup-apangea-for-use.sh

echo Vagrant Setup is now complete! See the README for a brief tutorial on functionality
