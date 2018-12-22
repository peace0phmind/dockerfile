FROM alpine

LABEL maintainer="peace0phmind@gmail.com"

ARG SS_LIBEV_VERSION=3.2.3
ARG SS_DOWNLOAD_URL=https://github.com/shadowsocks/shadowsocks-libev/releases/download/v${SS_LIBEV_VERSION}/shadowsocks-libev-${SS_LIBEV_VERSION}.tar.gz


ENV SERVER_ADDR 0.0.0.0
ENV SERVER_ADDR_IPV6 ::0
ENV SERVER_PORT 8388
ENV PASSWORD=
ENV METHOD      aes-256-gcm
ENV TIMEOUT     300
ENV DNS_ADDRS    8.8.8.8,8.8.4.4
ENV ARGS=

RUN apk add --no-cache --virtual .build-deps \
      autoconf \
      automake \
      build-base \
      c-ares-dev \
      libev-dev \
      libtool \
      libsodium-dev \
      linux-headers \
      mbedtls-dev \
      pcre-dev \
      curl \
      tar \
      xmlto \
      udns-dev \
    && curl -sSLO ${SS_DOWNLOAD_URL} \
    && tar -zxf shadowsocks-libev-${SS_LIBEV_VERSION}.tar.gz \
    && (cd shadowsocks-libev-${SS_LIBEV_VERSION} \
    && ./configure --prefix=/usr --disable-documentation \
    && make install) \
    && apk del .build-deps \
    && rm -rf shadowsocks-libev-${SS_LIBEV_VERSION}.tar.gz \
        shadowsocks-libev-${SS_LIBEV_VERSION} \
    # Runtime dependencies setup
    && apk add --no-cache \
         rng-tools \
         $(scanelf --needed --nobanner /usr/bin/ss-* \
          | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
          | sort -u)
    
USER nobody

CMD exec ss-server \
      -s $SERVER_ADDR \
      -s $SERVER_ADDR_IPV6 \
      -p $SERVER_PORT \
      -k ${PASSWORD:-$(hostname)} \
      -m $METHOD \
      -t $TIMEOUT \
      --fast-open \
      -d $DNS_ADDRS \
      -u \
      $ARGS
