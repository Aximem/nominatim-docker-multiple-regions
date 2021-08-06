#!/bin/bash

gpasswd -a postgres ssl-cert # Add this line

chown -R postgres:postgres /var/run/postgresql # Add this line
chown -R postgres:postgres /var/log/postgresql # Add this line
chown -R postgres:postgres /etc/postgresql # Add this line
chmod 600 /etc/ssl/private/ssl-cert-snakeoil.key # Add this line
chown postgres:ssl-cert /etc/ssl/private/ # Add this line
chown postgres:postgres /etc/ssl/private/ssl-cert-snakeoil.key # Add this line

stopServices() {
        service apache2 stop
        service postgresql stop
}
trap stopServices TERM

/app/src/build/utils/setup.php --setup-website

service postgresql start
service apache2 start

# fork a process and wait for it
tail -f /var/log/postgresql/postgresql-12-main.log &
wait