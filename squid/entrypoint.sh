#!/bin/sh

if [ ! -d "/var/cache/squid/00" ]; then
    /usr/sbin/squid -z
fi

/usr/sbin/squid -NYd1
