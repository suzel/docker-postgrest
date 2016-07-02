FROM ubuntu:14.04
MAINTAINER Sukru Uzel <sukru.uzel@gmail.com>

ENV POSTGREST_VERSION 0.3.2.0
ENV POSTGREST_DBHOST db_host
ENV POSTGREST_DBPORT 5432
ENV POSTGREST_DBNAME db_name
ENV POSTGREST_DBUSER db_user
ENV POSTGREST_DBPASS db_pass
ENV POSTGREST_SCHEMA public
ENV POSTGREST_ANONYMOUS postgres
ENV POSTGREST_JWT_SECRET secret
ENV POSTGREST_MAX_ROWS 1000000
ENV POSTGREST_POOL 200

RUN apt-get update && \
    apt-get install -y tar xz-utils wget libpq-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN wget http://github.com/begriffs/postgrest/releases/download/v${POSTGREST_VERSION}/postgrest-${POSTGREST_VERSION}-ubuntu.tar.xz && \
    tar --xz -xvf postgrest-${POSTGREST_VERSION}-ubuntu.tar.xz && \
    mv postgrest /usr/local/bin/postgrest && \
    rm postgrest-${POSTGREST_VERSION}-ubuntu.tar.xz

CMD exec postgrest postgres://${POSTGREST_DBUSER}:${POSTGREST_DBPASS}@${POSTGREST_DBHOST}:${POSTGREST_DBPORT}/${POSTGREST_DBNAME} \
        --port 3000 \
        --schema ${POSTGREST_SCHEMA} \
        --anonymous ${POSTGREST_ANONYMOUS} \
        --pool ${POSTGREST_POOL} \
        --jwt-secret ${POSTGREST_JWT_SECRET} \
        --max-rows ${POSTGREST_MAX_ROWS}

EXPOSE 3000