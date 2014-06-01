#!/usr/bin/env bash

installRVM()
{
    curl -L https://get.rvm.io | bash -s stable
    source /home/vagrant/.rvm/scripts/rvm
}

installRuby()
{
    source /home/vagrant/.rvm/scripts/rvm
    rvm install 1.9.3-p448 --patch railsexpress --verify-downloads 1
    rvm install 2.0-p247 --verify-downloads 1
    rvm install 2.0.0-p353 --verify-downloads 1
    rvm default 2.0.0-p353
}

installRVM
installRuby
