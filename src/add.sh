PGDIR=postgresdata

sudo -u postgres /usr/lib/postgresql/12/bin/pg_ctl -D /data/$PGDIR start && \
useradd -m -p password1234 nominatim && \
chown -R nominatim:nominatim ./src && \
chown -R nominatim:nominatim ./nominatim && \
sudo -u nominatim sh ./src/build/utils/add_multiple_regions.sh && \
sudo -u postgres /usr/lib/postgresql/12/bin/pg_ctl -D /data/$PGDIR stop