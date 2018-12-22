FROM alpine:3.8

LABEL maintainer="peace0phmind@gmail.com"

ARG TZ='Asia/Shanghai'

RUN apk upgrade \
	&& apk add tzdata \
	&& ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && rm /var/cache/apk/*

