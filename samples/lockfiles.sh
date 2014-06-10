#!/bin/bash

. setEnvironment.sh

LOCK=/tmp/$(basename $0).lock

if setLock $LOCK
then
  echo lock created
else
  set -x
  if rmStaleLock $LOCK 20
  then
    echo Old lock removed
    setLock $LOCK
  else
    echo Other instance exists
    exit
  fi
fi
sleep 60

removeLock $LOCK
