# PostgREST Docker Image

[![](https://img.shields.io/badge/Docker%20Hub-%E2%86%92-blue.svg)](https://hub.docker.com/r/suzel/docker-postgrest/ "Go to Docker Hub")

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

*docker-compose.yml*
```yml
version: '3.1'

services:
  postgrest:
    image: suzel/docker-postgrest:latest
    ports:
      - "3000:3000"
    environment:
      POSTGREST_VERSION: 0.4.0.0
    depends_on:
      - postgres
  postgres:
    image: postgres:latest
    ports:
      - "5432:5432"
    environment:
      POSTGRES_DB: app_db
      POSTGRES_USER: app_user
      POSTGRES_PASSWORD: secret
    volumes:
      - postgres-data:/var/lib/postgresql/data
      # - ./sql/init.sql:/docker-entrypoint-initdb.d/init.sql

volumes:
  postgres-data: {}
```

build and start:

```sh
$ docker-compose up -d --build
```

You can the visit the following URL in a browser on your host machine to get started:
```
open http://<docker_ip_address>:3000/<database_table>
```

## Resources

* [PostgREST Project](http://postgrest.com)
* [PostgREST Documentation](https://github.com/begriffs/postgrest)
* [PostgREST Official Container](https://hub.docker.com/r/begriffs/postgrest)