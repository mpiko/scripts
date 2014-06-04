#!/bin/bash

EPISODE=$1
ME=$(basename $0)

COMMAND=$(ps ax | grep $EPISODE | grep -v grep |grep -v $ME | cut -f11- -d" "| sed 's/&/\\&/g')

echo "$COMMAND" > ~/torrent/${EPISODE}.sh
chmod 755 ~/torrent/${EPISODE}.sh
echo CMD = $COMMAND
echo "Is now in ~/torrent/${EPISODE}.sh"
