#!/usr/bin/env bash

echo setup.sh: copying user-specific keys into vm based upon settings
lib/copy-user-specific-files.sh

# run the remainder of setup scripts on guest
/usr/bin/vagrant ssh -c 'cd /vagrant; ./lib/setup_on_guest.sh'
