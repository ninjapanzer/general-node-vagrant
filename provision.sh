#!/usr/bin/env bash

# Install postgres source & key
configPostgresPKGSource()
{
    /bin/cat > /etc/apt/sources.list.d/postgresql.list <<< "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main"
    /usr/bin/wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | /usr/bin/apt-key add -
}

installPostgres()
{
    configPostgresPKGSource

    apt-get update
    apt-get -y install libssl-dev postgresql-9.2 postgresql-client-9.2 \
        postgresql-contrib-9.2
}

installGit()
{
    apt-get -y install git
}

installRedis()
{
    apt-get -y install python-software-properties
    add-apt-repository -y ppa:rwky/redis
    apt-get -y update
    apt-get -y install redis-server
}

installNodejs()
{
    apt-get -y install python-software-properties
    add-apt-repository ppa:chris-lea/node.js
    apt-get update
    apt-get -y install nodejs
}

installPHP5cli()
{
    apt-get -y install python-software-properties
    apt-get update
    apt-get -y install php5-cli 
}

installMiscPackages()
{
    apt-get -y install build-essential libxslt-dev libxml2-dev libcurl4-openssl-dev \
        libpq-dev imagemagick libmagickwand-dev curl openjdk-6-jdk
}

setLocale(){
    update-locale LC_ALL=en_US.utf8
}

installPhantomJS()
{
    local phantom_name=phantomjs-1.9.2-linux-x86_64

    local SCRIPT=$(cat <<EOF
    cd /home/vagrant;
    wget https://phantomjs.googlecode.com/files/${phantom_name}.tar.bz2;
    bunzip2 ${phantom_name}.tar.bz2;
    sudo tar xvf ${phantom_name}.tar -C /opt/;
    rm ${phantom_name}.tar;
    echo "export PATH=/opt/${phantom_name}/bin:\\\$PATH" >> /home/vagrant/.bash_profile;
EOF
    )
    sudo -u vagrant bash -c "$SCRIPT"
}

installRepoBinDirectory()
{
    echo 'export PATH="/vagrant/bin:$PATH"' >> /home/vagrant/.bash_profile
}

sourceBashrc()
{
    echo 'source /home/vagrant/.bashrc' >> /home/vagrant/.bash_profile
}

installPostgres
installGit
installRedis
installMiscPackages
setLocale
installPhantomJS
installRepoBinDirectory
installNodejs
installPHP5cli
sourceBashrc
