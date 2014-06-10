#!/bin/bash

. setEnvironment.sh

LOCALSOURCE=$HOME
REMOTEDIR=/home/backup/laptop
REMOTEUSER=""
REMOTEHOST=ltsp
EXCLUDES="--exclude '*~' --exclude log --exclude Downloads --exclude .local/share/Trash"
LIMIT=1M
SWITCHES=axv
ARGS="--delete --partial --bwlimit=$LIMIT"
LOCKFILE=/tmp/$(basename $0).lock

#Set up the log files
buildpath $LOGDIR
cleandir $LOGDIR 2
recordscriptrun $(basename $0) $LOGBASE

# locking.
if ! setLock $LOCKFILE
then
  PID=$(cat $LOCKFILE)
  if isRunning $PID
  then
    : #Need to do stuff here.
  fi
  if isStaleFile $LOCKFILE 3000
  then
    removeLock $LOCKFILE
  else
    echo "an instance with pid $PID is already running"
    exit 1
  fi
  setLock $LOCKFILE
fi

if [ -z $REMOTEUSER ]
then
  rsync -$SWITCHES $ARGS $EXCLUDES -e ssh $LOCALSOURCE $REMOTEHOST:$REMOTEDIR > $LOGFILE
else
  rsync -$SWITCHES $ARGS $EXCLUDES -e ssh $LOCALSOURCE $REMOTEUSER@$REMOTEHOST:$REMOTEDIR > $LOGFILE
fi

removeLock $LOCKFILE
