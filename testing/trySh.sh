#!/bin/bash

. setEnvironment.sh

#set -x

LOGGING=y
logevent $LOGGING $LOGFILE "it barfed"
   

#IFS="
#"
#
#for LINE in $(cat ~/bin/allhosts.csv)
#do
#  IP=$(echo $LINE | cut -f1 -d,)
#  RHOST=$(echo $LINE | cut -f2 -d,)
#  RUSER=$(echo $LINE | cut -f3 -d,)
#  echo "IP = $IP, HOST = $RHOST, USER = $RUSER"
#done
