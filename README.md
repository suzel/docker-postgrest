# Docker PostgREST

[![](https://img.shields.io/badge/Docker%20Hub-%E2%86%92-blue.svg)](https://hub.docker.com/r/suzel/docker-postgrest/ "Go to Docker Hub")

[![](https://images.microbadger.com/badges/image/suzel/docker-postgrest.svg)](https://microbadger.com/images/suzel/docker-postgrest "Microbadger")

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
             -e POSTGREST_VERSION=0.3.2.0 \
             -e POSTGREST_DBHOST=localhost \
             -e POSTGREST_DBPORT=5432 \
             -e POSTGREST_DBNAME=database1 \
             -e POSTGREST_DBUSER=user \
             -e POSTGREST_DBPASS=password \
             -d suzel/docker-postgrest
```

You can the visit the following URL in a browser on your host machine to get started:
```
open http://$(docker-machine ip default):3000/<database_table>
```

## Resources

* [PostgREST Official Container](https://hub.docker.com/r/begriffs/postgrest)
* [PostgREST Documentation](https://github.com/begriffs/postgrest)