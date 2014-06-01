#!/usr/bin/env bash

configPG_HBA()
{
    # this changes the hba file to trust anyone from the local machine
    # this way we do not need a password to access the database
    sed -ibackup -E 's/host[[:space:]]+all[[:space:]]+all[[:space:]]+127.0.0.1\/32[[:space:]]+md5/host\tall\tall\t127.0.0.1\/32\ttrust/' /etc/postgresql/9.2/main/pg_hba.conf
}

installPGSQLConfig()
{
    # changes postgres configuration to use
    # UTF-8, since the apangea application requires it
    sed -ibackup -E "s/'en_US'/'en_US.UTF-8'/g" /etc/postgresql/9.2/main/postgresql.conf
    # changes postgres configuration to use
    # UTF-8, since the apangea application requires it
    sed -i -E "s/shared_buffers = 24MB/shared_buffers = 200kB/" /etc/postgresql/9.2/main/postgresql.conf
    sed -i -E "s/max_connections = 100/max_connections = 50/" /etc/postgresql/9.2/main/postgresql.conf

}

initializePGSQLDB()
{
    # some of this may be unnecessary/cargo culty
    /etc/init.d/postgresql stop
    rm -r /var/lib/postgresql/9.2/main
    sudo -u postgres /usr/lib/postgresql/9.2/bin/initdb -D /var/lib/postgresql/9.2/main
    /etc/init.d/postgresql start
}

createPGSQLVagrantUser()
{
    sudo -u postgres psql -c "CREATE USER vagrant WITH SUPERUSER"
}

configPG_HBA
installPGSQLConfig
initializePGSQLDB
createPGSQLVagrantUser
