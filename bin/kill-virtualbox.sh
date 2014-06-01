#!/usr/bin/env bash

# if some virtualbox instances die, this script will kill all vbox instances
ps ax | grep [V]irtualBox | awk '{print $1}' | xargs kill -9

