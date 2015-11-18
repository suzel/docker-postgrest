FROM ubuntu:14.04
MAINTAINER Sukru Uzel <sukru.uzel@gmail.com>

ENV POSTGREST_VERSION 0.2.12.1
ENV POSTGREST_DBHOST localhost
ENV POSTGREST_DBPORT 5432
ENV POSTGREST_DBNAME database
ENV POSTGREST_DBUSER user
ENV POSTGREST_DBPASS password

RUN apt-get update
RUN apt-get install -y tar xz-utils wget libpq-dev
RUN apt-get update

RUN wget http://github.com/begriffs/postgrest/releases/download/v${POSTGREST_VERSION}/postgrest-${POSTGREST_VERSION}-ubuntu.tar.xz
RUN tar --xz -xvf postgrest-${POSTGREST_VERSION}-ubuntu.tar.xz
RUN mv postgrest-${POSTGREST_VERSION} /usr/local/bin/postgrest

CMD postgrest --db-host ${POSTGREST_DBHOST} --db-port ${POSTGREST_DBPORT} \
              --db-name ${POSTGREST_DBNAME} --db-user ${POSTGREST_DBUSER} \
              --db-pass ${POSTGREST_DBPASS} --db-pool 200 \
              --anonymous postgres --port 3000 \
              --v1schema public

EXPOSE 3000

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*