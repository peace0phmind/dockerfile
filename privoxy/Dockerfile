FROM alpine

LABEL maintainer="peace0phmind@gmail.com"

ARG CONFIG_FILE=/etc/privoxy/config

RUN apk add --no-cache privoxy

COPY --chown=privoxy:privoxy config $CONFIG_FILE
RUN chmod +r $CONFIG_FILE

CMD /usr/sbin/privoxy --no-daemon --pidfile "/var/run/privoxy.pid" "/etc/privoxy/config"
