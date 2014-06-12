#!/bin/bash

setLock() {
# sets up lock files
# Usage: setLock file limit
# limit is used to check for stale lock files with
# age limit being a number of seconds
# Example: setLock $(basename $0).lock 60
  local LOCK=$1
  local CONTENT=$2
  [ ! -e $LOCK ] && echo $2 > $LOCK && return 0
  return 1
}

rmStaleLock() {
# removes stale lock files
# Usage: rmStaleLock file
# Example: removeLock $(basename $0).lock 3600
#    removes the lock if older than 60 minutes
  local LOCK=$1
  local LIMIT=$2
  if [ -e $LOCK ]
  then
      if isStaleFile $LOCK $LIMIT
      then
         rm $LOCK
         return 0
      fi
  fi
  return 1
}


removeLock() {
# removes lock files
# Usage: removeLock file
# Example: removeLock $(basename $0).lock
  local LOCK=$1
  [ -e $LOCK ] && rm $LOCK && return 0
  return 1
}
