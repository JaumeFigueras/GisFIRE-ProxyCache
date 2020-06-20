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
$ exit
```

## Setup meteo.cat data

### 3. Create the proxycache database

```bash
$ sudo -i -u postgres
$ createdb -p 5435 -E UTF8 -O gisfireuser meteocat
$ psql -p 5435 -d meteocat
# CREATE EXTENSION postgis;
# CREATE EXTENSION postgis_topology;
# ^d
$ exit
```

### 4. Add tables


### 5. Allow remote access to database, so GIS software can access all information

```bash
$ sudo -i -u postgres
$ createuser -p 5435 -P remotegisfireuser
$ psql -p 5435 -d meteocat
# GRANT CONNECT ON DATABASE meteocat TO remotegisfireuser;
# GRANT USAGE ON SCHEMA public TO remotegisfireuser;
# GRANT SELECT ON xdde_requests TO remotegisfireuser;
# GRANT SELECT ON ALL TABLES IN SCHEMA public TO remotegisfireuser;
# ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO remotegisfireuser;
# ^d
$ exit
```

### 6. Allow remote acces to postgres server

```bash
sudo nano /etc/postgresql/10/gisfire/postgresql.conf
--- change  
#listen_addresses = 'localhost'
--- to
listen_addresses = '*'

sudo nano /etc/postgresql/10/gisfire/pg_hba.conf
--- add
# IPv4 remote connections
host    all             remotegisfireuser       0.0.0.0/0       password
```

### 7. Flask Setup

```bash
sudo apt-get install python3-flask libapache2-mod-wsgi-py3 python-dev
sudo a2enmod wsgi

add config to site configuration

  WSGIScriptAlias /api /home/gisfire/test_flask.wsgi
  <Directory /home/gisfire/>
    # set permissions as per apache2.conf file
    Options FollowSymLinks
    AllowOverride None
    Require all granted
  </Directory>

```
