#!/bin/bash

. setEnvironment.sh

LOCALSOURCE=$HOME
REMOTEUSER=""
REMOTEHOST=ltsp
REMOTEDIR=/home/backup/laptop
EXCLUDES="--exclude '*~' --exclude log --exclude Downloads --exclude .local/share/Trash"
LIMIT=1M
SWITCHES=axv
ARGS="--partial --bwlimit=$LIMIT --delete"
LOCKFILE=/tmp/$ME.lock

#Set up the log files
buildpath $LOGDIR
cleandir $LOGDIR 2
recordscriptrun $ME $LOGBASE

# locking.
if [ -e $LOCKFILE ]
then
  PID=$(cat $LOCKFILE)
  if isRunning $PID
  then
    echo "An instance $ME is already running with pid $PID. Aborting."
    exit 30
  else
    removeLock $LOCKFILE
  fi
fi
setLock $LOCKFILE

if [ -z $REMOTEUSER ]
then
  rsync -$SWITCHES $ARGS $EXCLUDES -e ssh $LOCALSOURCE $REMOTEHOST:$REMOTEDIR > $LOGFILE
else
  rsync -$SWITCHES $ARGS $EXCLUDES -e ssh $LOCALSOURCE $REMOTEUSER@$REMOTEHOST:$REMOTEDIR > $LOGFILE
fi

removeLock $LOCKFILE
