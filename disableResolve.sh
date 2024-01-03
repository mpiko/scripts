#!/bin/bash

sudo systemctl stop systemd-resolved
sudo systemctl disable systemd-resolved

sudo cat >/etc/resolv.conf<<EOF
nameserver 10.10.10.100
options edns0 trust-ad
search cyder.com.au wombat.local
EOF
