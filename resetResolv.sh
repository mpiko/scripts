#!/bin/bash


if [ "$(id -u)" != "0" ] 
then
    echo "Only root can run this."
    exit 2
fi

RESOLV=$(grep nameserver /etc/resolv.conf | gawk '{print $2}'| cut -f1 -d.)
NET=$(hostname -I | cut -f1-3 -d.)

if [ $NET == "192.168.0" ] && [ $RESOLV == "127" ]
then
        echo "
nameserver 192.168.0.1
options edns0 trust-ad
" > /etc/resolv.conf
fi
