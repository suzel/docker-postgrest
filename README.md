# PostgREST Docker Image

[![Version](https://img.shields.io/badge/Version-7.0.1-blue.svg?style=flat-square)](https://github.com/begriffs/postgrest/tree/master "Version : 7.0.1")
[![Build Status](https://img.shields.io/travis/suzel/docker-postgrest/master?style=flat-square)](https://travis-ci.org/suzel/docker-postgrest "Travis CI")
[![Documentation](https://img.shields.io/badge/docs-latest-brightgreen.svg?style=flat-square)](http://postgrest.com "Documentation")
[![Docker Hub](https://img.shields.io/badge/Docker%20Hub-%E2%86%92-blue.svg?style=flat-square)](https://hub.docker.com/r/suzel/docker-postgrest/ "Go to Docker Hub")
[![Docker Stars](https://img.shields.io/docker/pulls/suzel/docker-postgrest.svg?style=flat-square)](https://hub.docker.com/r/suzel/docker-postgrest/ "Docker Pulls")

PostgREST serves a fully RESTful API from any existing PostgreSQL database.
It provides a cleaner, more standards-compliant, faster API than you are likely to write from scratch.

## Installation

The easiest way to get this docker image installed is to pull the latest version from the Docker registry:

```sh
docker pull suzel/docker-postgrest
```

or build from source:

```sh
git clone https://github.com/suzel/docker-postgrest.git
cd docker-postgrest/
docker build -t suzel/docker-postgrest --build-arg POSTGREST_VERSION=7.0.1 .
```

## Usage

Start your image binding external port 3000 in all interfaces to your container:

docker-compose.yml

```yml
version: "3.1"

services:
  # https://github.com/suzel/docker-postgrest
  postgrest:
    build:
      context: .
      args:
        POSTGREST_VERSION: "7.0.1"
    ports:
      - "3000:3000"
    environment:
      PGRST_DB_URI: postgres://app_user:secret@postgres:5432/app_db
      PGRST_DB_SCHEMA: public
      PGRST_DB_ANON_ROLE: app_user
    links:
      - postgres:postgres

  # https://github.com/sosedoff/pgweb
  pgweb:
    image: sosedoff/pgweb
    ports:
      - "8081:8081"
    links:
      - postgres:postgres
    environment:
      - DATABASE_URL=postgres://app_user:secret@postgres:5432/app_db?sslmode=disable
    depends_on:
      - postgres

  # https://hub.docker.com/_/postgres/
  postgres:
    image: postgres:alpine
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
docker-compose up -d --build
```

You can the visit the following URL in a browser on your host machine to get started:

```sh
# Open PostgREST Service
http://localhost:3000/

# Open database browser (pgweb)
http://localhost:8081/
```

## License

The source code is licensed under the [MIT license](LICENSE).
