# Docker PostgREST

PostgREST serves a fully RESTful API from any existing PostgreSQL database.
It provides a cleaner, more standards-compliant, faster API than you are likely to write from scratch.

## Installation

The easiest way to get this docker image installed is to pull the latest version from the Docker registry:

```
$ docker pull suzel/docker-postgrest
```

Build the docker-postgrest:

```sh
$ git clone https://github.com/suzel/docker-postgrest.git
$ cd docker-postgrest/
$ docker build -t suzel/docker-postgrest .
```

## Usage

Start your image binding external port 3000 in all interfaces to your container:

```sh
$ docker run --name postgrest-service \
             -p 3000:3000 \
             -e POSTGREST_VERSION=0.2.12.1 \
             -e POSTGREST_DBHOST=localhost \
             -e POSTGREST_DBPORT=5432 \
             -e POSTGREST_DBNAME=database1 \
             -e POSTGREST_DBUSER=user \
             -e POSTGREST_DBPASS=password \
             -d suzel/docker-postgrest
```

You can the visit the following URL in a browser on your host machine to get started:

```
http://127.0.0.1:3000/<database_table>
```

I want to run this with docker-compose, so I create the following file:

```yml
web:
  image: suzel/docker-php
  ports:
    - "80:80"
  links:
    - postgrest:postgrest
  volumes:
    - .:/usr/share/nginx/html

postgrest:
  image: suzel/docker-postgrest
  ports:
    - "3000:3000"
  environment:
    POSTGREST_VERSION: 0.2.12.1
    POSTGREST_DBHOST: postgres
    POSTGREST_DBPORT: 5432
    POSTGREST_DBNAME: app_db
    POSTGREST_DBUSER: app_user
    POSTGREST_DBPASS: password
  links:
    - postgres:postgres

postgres:
  image: postgres
  ports:
    - "5432:5432"
  environment:
    POSTGRES_DB: app_db
    POSTGRES_USER: app_user
    POSTGRES_PASSWORD: password
```