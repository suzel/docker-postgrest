#!/usr/bin/env bash

eval "$(docker-machine env default)"
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)

docker build --no-cache -t suzel/docker-postgrest .
docker run --name postgrest-service \
             -p 3000:3000 \
             -e POSTGREST_VERSION=0.3.0.2 \
             -e POSTGREST_DBHOST=localhost \
             -e POSTGREST_DBPORT=5432 \
             -e POSTGREST_DBNAME=database1 \
             -e POSTGREST_DBUSER=user \
             -e POSTGREST_DBPASS=password \
             -d suzel/docker-postgrest