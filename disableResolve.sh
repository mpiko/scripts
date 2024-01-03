#!/bin/bash
if [ $(id -u) -ne 0 ]
then
    sudo $0
else

systemctl stop systemd-resolved
systemctl disable systemd-resolved

rm /etc/resolv.conf

cat > /etc/resolv.conf<<EOF
nameserver 10.10.10.100
options edns0 trust-ad
search cyder.com.au wombat.local
EOF
fi
