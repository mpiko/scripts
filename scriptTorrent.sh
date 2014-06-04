#!/bin/bash


EPISODE=$1
ME=$(basename $0)

COMMAND=$(ps ax | grep $EPISODE | grep -v grep |grep -v $ME | cut -f11- -d" "| sed 's/&/\\&/g')

echo CMD = $COMMAND
echo "$COMMAND" > ~/torrent/${EPISODE}.sh
echo Is now in ~/torrent/${EPISODE}.sh
