Vagrant Environment
===================
This is an automated environment for running [Apangea](https://github.com/thinkthroughmath/apangea) in a VM

Quick Start for Mac
===================
#### Reading the entire readme before continuing is recommended

#### Prerequisites:
- [Github SSH key setup](https://help.github.com/articles/generating-ssh-keys)
- git

Run the following commands to get started.

```
$ git clone https://github.com/thinkthroughmath/vagrant-environment.git
$ cd vagrant-enviroment
$ ./bootstrap
$ vagrant ssh
$ cd /vagrant/apangea/
$ bundle exec foreman start -f Procfile.development
```
Visit [http://localhost:5001/](http://localhost:5001/) in your browser to see site running in VM

Note:
- You will be prompted for your administrator password during this process
- This setup process can take about an hour. You will see at the end telling you the process is done


Table of Contents
=================

 - [Overview](#overview-of-how-it-works)
 - [Setup](#setup)
   - [Download](#download)
   - [Run the bootstrap script](#run-the-bootstrap-script)
     - [Setup Host Machine Environment](#setup-host-machine-environment)
     - [Create env](#create-env)
     - [Start the virtual machine](#start-the-virtual-machine)
     - [Run the setup script](#run-the-setup-script)
   - [Load production school data](#load-production-school-data)
   - [Create a VM Snapshot](#create-a-vm-snapshot)
 - [How To Use](#how-to-use)
   - [A Vagrant Tutorial](#a-vagrant-tutorial)
     - [Starting Vagrant](#starting-vagrant)
     - [SSHing into Vagrant](#sshing-into-vagrant)
     - [Stopping the VM](#stopping-the-vm)
     - [Starting the Apangea Server: Raison d'etre](#starting-the-apangea-server-raison-detre)
   - [Dealing with Data](#dealing-with-data)
     - [Cloning a production school](#cloning-a-production-school)
 - [Other Tools](#other-tools)
   - [Kill Virtualbox](#kill-virtualbox)
   - [Add vagrant to Sudoers](#add-vagrant-to-sudoers)
 - [Troubleshooting](#troubleshooting)
     - [Setup runs but has a number of failures](#setup-runs-but-has-a-number-of-failures)
     - [Server launches but all requests fail due to database errors](#server-launches-but-all-requests-fail-due-to-database-errors)
     - [Server is running but fails to render pages which use solr](#server-is-running-but-fails-to-render-pages-which-use-solr)
     - [Redis server has port conflicts when launched](#redis-server-has-port-conflicts-when-launched)
     - [Test Github SSH](#test-github-ssh)

Overview of How it Works
========================

The Vagrant Environment project helps set up a
development environment.
The environment is set up
within a Linux virtual machine (the "guest"), and
runs upon your own laptop/machine (the "host").

Using a virtual machine for development gives us:
* a repeatable and stable environment upon which to work
* an environment to build upon for our own scripts
* an easily-recoverable environment in case of trouble
* an easier way to get new team members productive

Vagrant itself is a wrapper technology which makes the creation of
virtual machines scriptable. Essentially, Vagrant provides an elegant
scripting interface for Virtualbox.

Setup
=====

This process is scripted as much as is possible.

### Download

Acquire this repository. You can either clone this repository with
git:

    $ git clone https://github.com/thinkthroughmath/vagrant-environment.git

or if you do not have git installed, you use github's zip
facilities to download from this link:

[https://github.com/thinkthroughmath/vagrant-environment/archive/master.zip](https://github.com/thinkthroughmath/vagrant-environment/archive/master.zip)

### Run the bootstrap script

The bootstrap script does the following roughly in order.

#### Setup Host Machine Environment

The following software will be installed on the host machine via the bootstrap script:

- brew
- wget - Installed via brew
- VirtualBox - Installed via ./install-osx-host-software.sh script
- Vagrant - Installed via ./install-osx-host-software.sh script
- Vagrant Plugin (vbguest) - Installed via install-vagrant-plugins.sh script

#### Create env

We now need to provide the virtual machine with our personal
settings.
    
The env.sample copied and renamed to env is filled out by the script

Your github key and scalr credentials are added.

#### Start the virtual machine

The script then runs `vagrant up` from within the project.

This causes vagrant to read the `Vagrantfile` and bring up
a virtual machine. At this point, you should have a running Linux VM
to work with.

#### Run the setup script

The `setup.sh` script is designed to configure the linux VM to run
`apangea`.

It is run via:

    `./setup.sh`

It will take about an hour to run. You should get a message telling
you when setup process has completed.

Note: as the data archives are not working right now, data restoring
from the server does not work. Thus, no production data is loaded from
the server. The model home facilities are available, however.

### Load production school data

The `load-production-schools.sh` script is designed to import a live school from production as defined by the `.schools-to-clone` config file. By default the cloned school will be 10501 see [.schools-to-import](.schools-to-import) to see the default setup.

If you would like to clone a different school by default update the ID reference in the above file.

### Create a VM Snapshot

After you have verified that the VM is setup and  working as expected, save a snapshot
of your VirtualBox VM. If something should break with the VM in the future, this
step could save you time since you won't have to run setup again to restore
the VM.

To create a snapshot, do the following:

1. If your VM is running, shut it down by running: $vagrant halt
2. Open VirtualBox
3. Locate the Vagrant VM in VirtualBox's list of VMs - ensure that it is selected
4. Select "Snapshots"
5. Select "Take Snapshot"
6. Name the snapshot something meaningful like: "Initial Setup Complete"
7. Click "OK" to create the snapshot

With this snapshot created, you can restore your VM to this point in time
by choosing "Restore Snapshot" from this menu.

Thats it! Assuming all goes well, the environment should be set up for
you. See the "A Vagrant Tutorial" section for a brief tutorial.

How To Use
==========

## A Vagrant Tutorial

You'll need some familiarity with how Vagrant works in order to use it.

By design, a 'vagrant' user is created in the virtual
machine. Whenever working with it, we will be using the 'vagrant'
user.

Additionally, the directory on the host machine
that contains the guest virtual machine's
`Vagrantfile` is shared with the guest machine at as '/vagrant'. Thus,
if you change
any files on your host machine in that directory, the changes will
appear in the guest
virtual machine. Conversely, any changes made within the shared
'/vagrant' directory in the VM are also reflected in the host
machine's system. Thus, you may use whichever editor you like, and the
changes will be transferred to the virtual machine.

#### Starting Vagrant

If you have just set up the VM with the `setup.sh` script, the VM
should be running. However, if the VM is shut down in the future,
the command:

    `vagrant up`

will start the machine again.

#### SSHing into Vagrant

The command `vagrant ssh` will start an ssh session into the VM.
This is just a normal ssh session.

#### Stopping the VM

The command `vagrant halt` will stop the VM, thus saving OS
resources.

#### Starting the Apangea Server: Raison d'etre

So you want to run a local copy of Apangea for development. We assume
the virtual machine is running.

0. If it isn't you'll need to start it with `vagrant up`.

1. SSH into the machine with `vagrant ssh`

2. Change to the apangea repository with `cd /vagrant/apangea`

3. Start foreman with `bundle exec foreman start -f Procfile.development`

4. Browse the running application at 'localhost:5001'!

## Dealing with Data

### Cloning a production school

From within your vagrant VM you can restore school by ID by running `/vagrant/lib/provision-production-content.sh <school_id>`

_Its important that redis and foreman are not running when you you use this command as it will startup foreman on its own when issuing a `solr reindex`_

For example:
```
/vagrant/lib/provision-production-content.sh 10501
```

Other Tools
===========

#### Kill Virtualbox

If your virtual machine seems to get stuck, you kill all virtualbox processes via the script

`bin/kill-virtualbox.sh`

#### Add vagrant to Sudoers

If you don't want to type a password during vagrant up for NFS sync

`bin/install-vagrant-sudoers.sh`

Afterwards start the virtual machine again with `vagrant up`, and you can try connecting again with `vagrant ssh`.

Troubleshooting
===============

While the aim of the installer is to automate the entire setup process, there are
a couple common errors which will prevent the VM from being properly setup. 
This section provides pointers for how to resolve these common issues.

#### Setup runs but has a number of failures

It's possible that something didn't get setup properly when the VM was first
brought up (provisioned). As a first step, try to destroy the VM and recreate 
it with the following commands:

    $ vagrant destroy
    $ vagrant up

If the provisioning looks to have run successfully, try to run setup.sh again to see if the
failures have been resolved.

#### Server launches but all requests fail due to database errors

It's possible that the step which rebuilds with production content has failed.
Try running these commands to resolve the issue:

    $ vagrant ssh
    $ cd /vagrant/apangea
    $ bundle exec rake ttm:rebuild_with_production_content

If successful, you should see the TTM login page when navigating to your
dev server.

#### Server is running but fails to render pages which use solr

It's possible that the solr index hasn't been fixed. Try running these commands
to correct the problem:

Note: Be careful to type the "rm -rI" command exactly as shown. Otherwise, you
could have a bigger problem on your hands.    

    $ vagrant ssh
    $ cd /vagrant/apangea
    $ rm -rI solr/data/development/index
    $ bundle exec rake sunspot:solr:start
    $ bundle exec rake sunspot:solr:reindex # Answer "yes" when prompted
    $ bundle exec rake sunspot:solr:stop

If successful, the pages which use solr to render should now be rendering properly.

#### Redis server has port conflicts when launched

It's possible that Redis server has been enabled to launch automatically on 
VM startup.

Run the following commands to see if Redis is automatically being launched:

    $ vagrant ssh
    $ ls /etc/init/ |grep redis

If the output of the previous command is:

    redis-server.conf

then run the following commands to disable automatic startup of Redis:

    $ vagrant ssh
    $ sudo mv /etc/init/redis-server.conf /etc/init/redis-server.conf.disabled

If Redis is running, you may still need to kill the service manually to solve
the port conflict problem (until the VM is restarted). Run these commands to kill the
service:

    $ vagrant ssh
    $ sudo service redis-server stop

After these changes have been made, the Redis server port conflict issue 
should be fully resolved now and after future reboots of the VM.

#### Test Github SSH

It is possible that you did not set up your ssh key on github correctly.
To verify it is working correctly run the command below.

  `$ ssh -T git@github.com`
  
If everything is working you should then see this:

  `Hi username! You've successfully authenticated, but GitHub does not provide shell access.`
  
If you did not get this please follow the steps to setup [Github SSH Keys](https://help.github.com/articles/generating-ssh-keys).

Note: You may be asked to verify your RSA key's finger print. This is normal.
