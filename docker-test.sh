#!/usr/bin/env bash

docker-machine start default
eval "$(docker-machine env default)"

docker stop postgres-db && docker rm postgres-db
docker stop postgrest-service && docker rm postgrest-service

docker build --no-cache -t suzel/docker-postgrest .

docker run --name postgres-db \
           -p 5432:5432 \
           -e POSTGRES_DB=database1 \
           -e POSTGRES_USER=user \
           -e POSTGRES_PASSWORD=password \
           -d postgres

docker run --name postgrest-service \
           --link postgres-db:postgres \
           -p 3000:3000 \
           -e POSTGREST_VERSION=0.3.2.0 \
           -e POSTGREST_DBHOST=$(docker-machine ip default) \
           -e POSTGREST_DBPORT=5432 \
           -e POSTGREST_DBNAME=database1 \
           -e POSTGREST_DBUSER=user \
           -e POSTGREST_DBPASS=password \
           -e POSTGREST_SCHEMA=public \
           -e POSTGREST_ANONYMOUS=postgres \
           -e POSTGREST_JWT_SECRET=secret \
           -e POSTGREST_MAX_ROWS=1000000 \
           -e POSTGREST_POOL=200 \
           -d suzel/docker-postgrest

open http://$(docker-machine ip default):3000
docker exec -it postgrest-service bash