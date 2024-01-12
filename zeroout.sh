#!/bin/bash

AVAIL=$(df / | tail -1 | gawk '{print $4}')

sudo mkdir /tmpdd
cd /tmpdd
echo Free Space: $AVAIL
BUFFER=$(($AVAIL / 20))
SIZE=$(($AVAIL - $BUFFER))
#echo $SIZE
echo dd if=/dev/zero of=dump.$$ bs=1k count=$SIZE status=progress
sudo dd if=/dev/zero of=dump.$$ bs=1k count=$SIZE status=progress
sudo rm dump.$$
sudo rm -rf /tmpdd
