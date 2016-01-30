FROM ubuntu:14.04
MAINTAINER Sukru Uzel <sukru.uzel@gmail.com>

ENV POSTGREST_VERSION 0.3.0.3
ENV POSTGREST_DBHOST host
ENV POSTGREST_DBPORT 5432
ENV POSTGREST_DBNAME database
ENV POSTGREST_DBUSER user
ENV POSTGREST_DBPASS password

RUN apt-get update
RUN apt-get install -y tar xz-utils wget libpq-dev

RUN wget http://github.com/begriffs/postgrest/releases/download/v${POSTGREST_VERSION}/postgrest-${POSTGREST_VERSION}-ubuntu.tar.xz
RUN tar --xz -xvf postgrest-${POSTGREST_VERSION}-ubuntu.tar.xz
RUN mv postgrest /usr/local/bin/postgrest

CMD postgrest postgres://${POSTGREST_DBUSER}:${POSTGREST_DBPASS}@${POSTGREST_DBHOST}:${POSTGREST_DBPORT}/${POSTGREST_DBNAME} \
              --port 3000 \
              --schema public \
              --anonymous postgres \
              --pool 200

EXPOSE 3000

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*