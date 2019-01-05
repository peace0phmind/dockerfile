FROM alpine

LABEL maintainer="peace0phmind@gmail.com"


RUN apk add --no-cache squid

COPY squid.conf /etc/squid/squid.conf
COPY entrypoint.sh /entrypoint.sh

EXPOSE 3128 3128

ENTRYPOINT ["/entrypoint.sh"]
