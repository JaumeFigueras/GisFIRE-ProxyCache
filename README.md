# GisFIRE-ProxyCache
Set of software to store as a proxycache different data that comes from different sources

## Setup (general)

### 1. Create a postgres cluster

```bash
$ sudo mkdir -p /home/db/postgres/gisfire
$ sudo chown postgres:postgres /home/db/postgres/gisfire
$ sudo pg_createcluster -d /home/db/postgres/gisfire -l /home/db/postgres/gisfire/gisfire.log -p 5435 --start --start-conf auto 10 gisfire
```

### 2. Create a gisfire database user

```bash
$ sudo -i -u postgres
$ createuser -p 5435 -P gisfireuser
```

## Setup meteo.cat data

### 3. Create the proxycache database

```bash
$ createdb -p 5435 -E UTF8 -O gisfireuser meteocat
$ psql -p 5434 -d meteocat
\## CREATE EXTENSION postgis;
\## CREATE EXTENSION postgis_topology;
\## ^d
$ exit
```
