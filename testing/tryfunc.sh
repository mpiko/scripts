#!/bin/bash

#. devfunctions.sh
. setEnvironment.sh
echo "Starting script"
LOCKFILE=$ME.lock
checkforlock $LOCKFILE
setLock $LOCKFILE $$
echo "lock should be set"
ls -l $LOCKFILE
#removeLock $LOCKFILE

echo closing script
