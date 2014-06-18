#!/bin/bash
#
# Michael Piko
# Description: 
# Date created:  18-06-2014
# last modified: dd-mm-20yy

#-# Usage: 
#-# 
#-#
#-#
#-# Description:
#-#
#-# Example:

# Script Variables:
DNSNAME=michaelpiko.no-ip.biz
NOIP2=/usr/local/bin/noip2

#see setEnvironment.sh, functions.sh, and variables.sh for explainations
. setEnvironment.sh

#buildpath $LOGDIR
#cleandir $LOGDIR 2
#recordscriptrun $(basename $0) $LOGBASE


# if ! enoughArgs +0 $#
# then
#  usage
#  exit 100
#fi

VERBOSE=n
if [ $# -eq 1 ] && [ $1 = "-v" ]
then
  VERBOSE=y
  shift
fi

# if the host is up then we can stop.
if isHostUp $DNSNAME
then
  # all good.
  onScreen $VERBOSE "$DNSNAME is up"
  exit 0
fi

# Host must be down. restart noip2 if running
PROCESS=$(ps ax | grep $NOIP2 | grep -v grep)
if [ ! -z "$PROCESS" ]
then
  PID=$(echo $PROCESS | cut -f1 -d" ")
  onScreen $VERBOSE "killing $PID"
  sudo kill $PID
fi
exec sudo $NOIP2

