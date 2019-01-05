FROM alpine

LABEL maintainer="peace0phmind@gmail.com"

RUN apk add --no-cache squid

EXPOSE 3128 3128

ENTRYPOINT ["/usr/sbin/squid", "-NYCd1"]
