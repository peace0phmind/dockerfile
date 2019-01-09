FROM debian:9-slim

LABEL maintainer="peace0phmind@gmail.com"

ADD https://files.freeswitch.org/repo/deb/freeswitch-1.8/fsstretch-archive-keyring.asc .

RUN apt-get update && apt-get install -y \
      gnupg \
      apt-utils \
    && apt-key add fsstretch-archive-keyring.asc \
    && rm -f fsstretch-archive-keyring.asc \
    && echo "deb http://files.freeswitch.org/repo/deb/freeswitch-1.8/ stretch main" > /etc/apt/sources.list.d/freeswitch.list \
    && echo "deb-src http://files.freeswitch.org/repo/deb/freeswitch-1.8/ stretch main" >> /etc/apt/sources.list.d/freeswitch.list \
    && apt-get update && apt-get install -y freeswitch-meta-all
