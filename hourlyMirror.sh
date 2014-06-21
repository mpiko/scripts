#!/bin/bash

. setEnvironment.sh

LOCALSOURCE=$HOME
REMOTEUSER=""
REMOTEHOST=ltsp
REMOTEDIR=/home/backup/laptop
EXCLUDES="--exclude '*~' --exclude log --exclude Downloads --exclude .local/share/Trash"
LIMIT=1024
SWITCHES=axv
ARGS="--partial --bwlimit=$LIMIT --delete"
LOCKFILE=/tmp/$ME.lock

#Set up the log files
buildpath $LOGDIR
cleandir $LOGDIR 2
recordscriptrun $ME $LOGBASE

if [ -z $REMOTEUSER ]
then
  COMMAND="rsync -$SWITCHES $ARGS $EXCLUDES -e ssh $LOCALSOURCE $REMOTEHOST:$REMOTEDIR"
else
  COMMAND="rsync -$SWITCHES $ARGS $EXCLUDES -e ssh $LOCALSOURCE $REMOTEUSER@$REMOTEHOST:$REMOTEDIR"
fi

# locking.
if [ -e $LOCKFILE ]
then
  PID=$(cat $LOCKFILE)
  if isRunning $PID
  then
    echo "An instance $ME is already running. Aborting." > $LOGFILE
    exit 30
   else
     removeLock $LOCKFILE
  fi
fi

setLock $LOCKFILE $$
$COMMAND > $LOGFILE
removeLock $LOCKFILE
