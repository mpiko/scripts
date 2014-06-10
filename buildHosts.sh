#!/bin/bash

HOSTS="media@media-laptop pi@pi ltsp"

cd $HOME/bin

# me first!
echo Updating laptop
cp allhosts.txt /tmp
cat /etc/hosts > /tmp/backup_hosts.txt;
head -3 /etc/hosts > /tmp/newhosts;
cat /tmp/allhosts.txt >> /tmp/newhosts;
sudo su -c "cat /tmp/newhosts > /etc/hosts"


for DEST in $HOSTS
do
  echo Updating $DEST
  scp allhosts.txt $DEST:/tmp > /dev/null 2>&1
  if [ $? -eq 0 ]
  then
    ssh $DEST "sudo cat /etc/hosts > /tmp/backup_hosts.txt;
    head -2 /etc/hosts > /tmp/newhosts;
    cat /tmp/allhosts.txt >> /tmp/newhosts;
    sudo su -c \"cat /tmp/newhosts > /etc/hosts\""
  else
    echo "$DEST is unreachable"
  fi
done
