#!/usr/bin/env bash
COMMAND=$1

vagrant ssh-config > .vagrant-connect
echo '  ServerAliveInterval 60' >> .vagrant-connect

case "$COMMAND" in
"server")
    ssh -F .vagrant-connect default -t 'cd /vagrant/apangea; source /home/vagrant/.bash_profile; foreman start -f Procfile.development'
    ;;
"console")
    ssh -F .vagrant-connect default -t 'source /home/vagrant/.bash_profile; cd apangea; rails c;'
    ;;
"test_start")
    ssh -F .vagrant-connect default -t 'source /home/vagrant/.bash_profile; cd /vagrant/apangea; rake db:test:prepare; RAILS_ENV=test rake servers:start;'
    ;;
"test_stop")
    ssh -F .vagrant-connect default -t 'source /home/vagrant/.bash_profile; cd /vagrant/apangea; RAILS_ENV=test rake servers:stop;'
    ;;
*)
    echo "Executing $COMMAND in /vagrant"
    ssh -F .vagrant-connect default -t "cd /vagrant; source /home/vagrant/.bash_profile; $COMMAND"
    ;;
esac

rm .vagrant-connect
