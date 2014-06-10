#!/bin/bash

HOSTS="media@media-laptop pi@pi ltsp"
HOSTS="media@media-laptop ltsp"

# me first!
echo laptop
cp allhosts.txt /tmp
cat /etc/hosts > /tmp/backup_hosts.txt;
head -2 /etc/hosts > /tmp/newhosts;
cat /tmp/allhosts.txt >> /tmp/newhosts;
sudo su -c "cat /tmp/newhosts > /etc/hosts"


for DEST in $HOSTS
do
  echo $DEST
  scp allhosts.txt $DEST:/tmp
  ssh $DEST "sudo cat /etc/hosts > /tmp/backup_hosts.txt;
  head -2 /etc/hosts > /tmp/newhosts;
  cat /tmp/allhosts.txt >> /tmp/newhosts;
  sudo su -c \"cat /tmp/newhosts > /etc/hosts\""
done
