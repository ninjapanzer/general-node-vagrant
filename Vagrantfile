# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box     = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  config.vm.provision :shell, path: 'provision.sh'

  # rails
  config.vm.network "forwarded_port", guest: 3000, host: 3001

  # live teaching
  config.vm.network "forwarded_port", guest: 5000, host: 5001

  # devblog
  config.vm.network "forwarded_port", guest: 4000, host: 4001

  # node
  config.vm.network "forwarded_port", guest: 8080. host: 8081

  # javascript livereload
  # livereload does not support using a different port because lol
  config.vm.network "forwarded_port", guest: 35_729, host: 35_729

  # Solr
  config.vm.network "forwarded_port", guest: 8982, host: 8982

  # update guest additions automaticlly without downloading the iso
  config.vbguest.auto_update = false
  config.vbguest.no_remote = false

  config.vm.provider "virtualbox" do |vb|
    # get host OS from the ruby config
    host_os = RbConfig::CONFIG['host_os']

    if host_os =~ /darwin/
      cpus = `sysctl -n hw.ncpu`.to_i
      # eliminate hyperthreaded cores from the count
      cpus = cpus/2
    else
      cpus = 2
    end

    vb.customize ["modifyvm", :id, "--memory", "2048"]
    vb.customize ["modifyvm", :id, "--cpus", cpus]
  end

  config.vm.synced_folder ".", "/vagrant", nfs: true

  config.vm.network "private_network", ip: "192.168.50.4"
end

extra_file = File.expand_path('../Vagrantfile.extra', __FILE__)
load extra_file if File.exists?(extra_file)
