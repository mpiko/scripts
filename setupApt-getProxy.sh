#!/bin/bash
#
# Michael Piko
# Description: 
# Date created:  16-06-2014
# last modified: dd-mm-20yy

#see setEnvironment.sh, functions.sh, and variables.sh for explaination
. setEnvironment.sh

REMOTE="$1"


if isHostUp $REMOTE
then
  scp 01proxy $REMOTE:
  ssh $REMOTE "sudo mv 01proxy /etc/apt/apt.conf.d/"
else
  echo Could not contact $RHOST
fi

