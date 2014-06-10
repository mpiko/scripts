#!/bin/bash

# sets up lock files
# Usage: setLock file limit
# limit is used to check for stale lock files with
# age limit being a number of seconds
# Example: setLock $(basename $0).lock 60
setLock() {
  local LOCK=$1
  [ ! -e $LOCK ] && echo $$ > $LOCK && return 0
  return 1
}

rmStaleLock() {
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


# removes lock files
# Usage: removeLock file
# Example: removeLock $(basename $0).lock
removeLock() {
  local LOCK=$1
  [ -e $LOCK ] && rm $LOCK && return 0
  return 1
}
