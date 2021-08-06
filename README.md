[Nominatim Docker](https://github.com/mediagis/nominatim-docker) extension to manage Nominatim multiple regions container.

# Nominatim commands Multiple regions

1. Build Nominatim Image

```
docker build --pull --rm -t nominatim .
```

2. Update file `multiple_regions/init_multiple_regions.sh`

Replace:

```
COUNTRIES="europe/monaco europe/andorra"
```

with your regions

3. Init multiple regions with **init script**

```
docker run -t -v /home/me/nominatimdata:/data nominatim sh /app/multiple_regions/init.sh
```

_Note: Replace `/home/me/nominatimdata` with your local path (e.g. `Users/aximem/Desktop/Nominatim/nominatimdata`)  
If you need to add other regions, use **add script** below. Init script will erase database each time you run it_

# Run Nominatim server

1. Start container

`docker run --restart=always -p 6432:5432 -p 7070:8080 -d --name nominatim -v /home/me/nominatimdata/postgresdata:/var/lib/postgresql/12/main nominatim bash /app/start.sh`

2. Access application

Access url: `http://localhost:7070/search?q=Casino`

To perform specific search, checkout the [Nominatim documentation](https://nominatim.org/release-docs/develop/api/Overview/)

# Custom commands Multiple regions

## Add multiple regions

If you already set up the database with init script and want to add new regions, you can use **add script**

1. Update file `multiple_regions/add_multiple_regions.sh`

Replace:

```
COUNTRIES="europe/monaco europe/andorra"
```

with your regions

2. Add multiple regions

```
docker run -t -v /home/me/nominatimdata:/data nominatim sh /app/multiple_regions/add.sh
```

## Update multiple regions

If you want to keep your datas updated, you can use **update script**

1. Update file `multiple_regions/update_multiple_regions.sh`

Replace:

```
COUNTRIES="europe/monaco europe/andorra"
```

with **ALL your regions**, the ones set into init script and the ones added with add script.

2. Update multiple regions

```
docker run -t -v /home/me/nominatimdata:/data nominatim sh /app/multiple_regions/update.sh
```
