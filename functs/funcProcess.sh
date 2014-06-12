#!/bin/bash -x


isRunning() {
  local PID=$1
  [ -z $PID ] && return 1
  local RUNNING=$(ps ax | grep "^$PID" | cut -f1 -d" ")
  [ -z "$RUNNING" ] && return 1
  return 0
}

dieIfNotEnoughArgs() {
# Usage: dieIfNotEnoughArgs x $#
# Example: dieIfNotEnoughArgs 3 $#
  local NEEDED=$1
  local SUPPLIED=$2
  if [ -z $NEEDED ] || [ -z $SUPPLIED ]
  then
     echo "Invalid use of dieIfNotEnoughArgs"
     echo Usage  dieIfNotEnoughArgs x \$#
     exit
  fi
  if [ $SUPPLIED -ne $NEEDED ]
  then
    echo "$ME: Not enough args supplied"
    exit
  fi
}

enoughArgs() {
# Usage: checkEnoughArgs x $#
# Example: if checkEnoughArgs 3 $#; then...
#      or: if enoughArgs +3 $#; then ...
# in the second example, there needs to be 3 or more args supplied.
# note the '+' indicates 3 or more.
  local NEEDED=$1
  local SUPPLIED=$2
  if [ -z $NEEDED ] || [ -z $SUPPLIED ]
  then
     echo "Invalid use of checkEnoughArgs"
     echo Usage  checkEnoughArgs x \$#
     exit
  fi
  CHAR1=$(echo $NEEDED | cut -c1)
  if [ $CHAR1 = '+' ]
  then
     NEEDED=$(echo $NEEDED | sed 's/+//')
     if [ $SUPPLIED -ge $NEEDED ]
     then
       return 0
     fi
  fi
  if [ $SUPPLIED -eq $NEEDED ]
  then
    return 0
  fi
  return 1
}
