#!/usr/bin/env bash
#
# Apangea Setup One Liner :)

welcome() {
  echo 'Lets get Apangea running'
  echo 'This process will fail if you have setup ssh access on github as specified in the readme'
}

userInput() {
  printf "\r  [ \033[0;33m?\033[0m ] $1 "
}

checkHomebrew()
{
  if test ! $(which brew)
  then
    echo " Installing Homebrew. "
    ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go/install)"
  fi
}

brewUpdate()
{
  brew update > /dev/null
}

brewWget()
{
  if test ! $(which wget)
  then
    echo " Installing wget. "
    brew install wget > /dev/null
  fi
}

checkVagrant()
{
  if test ! $(which vagrant)
  then
    echo " Installing Vagrant. "
    ./lib/download-install-vagrant.sh
  fi
}

checkVagrantPlugins()
{
  if test ! $(vagrant plugin list | grep vbguest)
  then
    echo " Installing Vagrant Plugins "
    ./lib/install-vagrant-plugins.sh
  fi
}

checkVirtualBox()
{
  if test ! $(which Virtualbox)
  then
    echo " Installing VirtualBox. "
    ./lib/download-install-virtualbox.sh
  fi
}

setupEnv()
{
  is_correct="n"

  while [ "$is_correct" !=  "y" ]; do
    userInput ' - What is your Scalr Key ID? '
    read -e scalr_key_id
    userInput ' - what is your Scalr Access Key? '
    read -e scalr_access_key

    echo
    echo "Scalr Key ID: $scalr_key_id"
    echo "Scalr Access Key: $scalr_access_key"
    echo

    userInput ' - Are the above values correct? [y/n] '
    read is_correct
  done

  scalr_key_id_escaped=$(printf $scalr_key_id | sed -e 's/[\/&]/\\&/g')
  scalr_access_key_escaped=$(printf $scalr_access_key | sed -e 's/[\/&]/\\&/g')

  sed -e "s/<YOUR_KEY_ID>/$scalr_key_id_escaped/g" -e "s/<YOUR_ACCESS_KEY>/$scalr_access_key_escaped/g" <env.sample >env
}

vagrantUp()
{
  vagrant up
}

runSetup(){
  ./setup.sh
}

createSnapshot()
{
  if test $(which VBoxManage)
  then

    userInput ' - Do you want to take a Snapshot of the machine? [y/n] '
    read -e user_response

    if [ "$user_response" = "y" ]
    then
      echo "Creating VM Snapshot named 'Initial Vagrant Setup'"
      machine_id=$(<$(dirname "${BASH_SOURCE[0]}")/.vagrant/machines/default/virtualbox/id)
      VBoxManage snapshot $machine_id take "Initial Vagrant Setup"
    fi
  fi
}

welcome
setupEnv
checkHomebrew
brewUpdate
brewWget
checkVagrant
checkVagrantPlugins
checkVirtualBox
vagrantUp
runSetup
createSnapshot
