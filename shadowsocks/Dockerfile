FROM alpine

LABEL maintainer="peace0phmind@gmail.com"

ARG SS_LIBEV_VERSION=3.2.3
ARG KCP_VERSION=20181114

ARG SS_DOWNLOAD_URL=https://github.com/shadowsocks/shadowsocks-libev/releases/download/v${SS_LIBEV_VERSION}/shadowsocks-libev-${SS_LIBEV_VERSION}.tar.gz
ARG OBFS_DOWNLOAD_URL=https://github.com/shadowsocks/simple-obfs.git
ARG KCP_DOWNLOAD_URL=https://github.com/xtaci/kcptun/releases/download/v${KCP_VERSION}/kcptun-linux-amd64-${KCP_VERSION}.tar.gz

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
      git \
    # build ss
    && curl -sSLO ${SS_DOWNLOAD_URL} \
    && tar -zxf shadowsocks-libev-${SS_LIBEV_VERSION}.tar.gz \
    && (cd shadowsocks-libev-${SS_LIBEV_VERSION} \
    && ./configure --prefix=/usr --disable-documentation \
    && make install) \
    # build simple-obfs
    && git clone ${OBFS_DOWNLOAD_URL} \
    && (cd simple-obfs \
    && git submodule update --init --recursive \
    && ./autogen.sh && ./configure --disable-documentation\
    && make && make install) \
    # install kcp
    && curl -sSLO ${KCP_DOWNLOAD_URL} \
    && tar -zxf kcptun-linux-amd64-${KCP_VERSION}.tar.gz \
    && mv server_linux_amd64 /usr/bin/kcpserver \
    && mv client_linux_amd64 /usr/bin/kcpclient \
    # clear sys
    && apk del .build-deps \
    && rm -rf shadowsocks-libev-${SS_LIBEV_VERSION}.tar.gz \
        shadowsocks-libev-${SS_LIBEV_VERSION} \
        kcptun-linux-amd64-${KCP_VERSION}.tar.gz \
        simple-obfs \
    # Runtime dependencies setup
    && apk add --no-cache \
         rng-tools \
         $(scanelf --needed --nobanner /usr/bin/ss-* \
          | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
          | sort -u)

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]