#!/bin/bash

#. setEnvironment.sh

ps ax | grep "$1" | grep -v grep | grep -v `basename $0` | grep -v defunct | cut -f2- -d":" | cut -f2- -d" " > /tmp/torrent.$$

FILE=$(cat /tmp/torrent.$$ | cut -f3 -d= | sed 's/+/-/g' | sed 's/&/-/g')

mv /tmp/torrent.$$ ~/torrent/${FILE}.sh
