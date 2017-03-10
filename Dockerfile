FROM ubuntu:16.04
MAINTAINER Sukru Uzel <sukru.uzel@gmail.com>

ENV POSTGREST_VERSION 0.4.0.0

RUN apt-get update && \
    apt-get install -y tar xz-utils wget libpq-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN wget http://github.com/begriffs/postgrest/releases/download/v${POSTGREST_VERSION}/postgrest-${POSTGREST_VERSION}-ubuntu.tar.xz && \
    tar --xz -xvf postgrest-${POSTGREST_VERSION}-ubuntu.tar.xz && \
    mv postgrest /usr/local/bin/postgrest && \
    rm postgrest-${POSTGREST_VERSION}-ubuntu.tar.xz

ADD ./config/postgrest.conf /etc/postgrest.conf
CMD exec postgrest /etc/postgrest.conf

EXPOSE 3000