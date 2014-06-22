#!/bin/bash -x

logevent() {
# tests to see if logging of events are wanted.
# Usage: if logevent "y log/logfile "message text"; then ...
# Example: if logevent "script filed"; then exit 1; fi
  local LOGEVENT=$1
  local LOGEVENTFILE=$2
  shift 2
  if [ $LOGEVENT = 'y' ]
  then
    TODAY=$(getDate)
    TIME=$(getTime)
    echo "$TODAY_$TIME: $@" >> $LOGEVENTFILE
    return 0
  fi
  return 1
  
}


usage() {
# Intend to display the usage clause from a script.
# Usage: usage
# Example: if ! enoughArgs 2 $#; then usage ; exit 2; fi
# if runs back off to the calling script to find the usage clause.
# the clause must be properly formatted: "#-#"
#
  SCRIPT=$(which $ME)
  IFS="
"
  FOUND="FALSE"
  for LINE in $(cat $SCRIPT)
  do
      TMP=$(echo $LINE | grep "^#-#")
      if [ ! -z $TMP ]
      then
         FOUND="TRUE"
      fi
      if [ $FOUND = "TRUE" ]
      then
          CHAR=$(echo $LINE | cut -c1-3)
          if [ $CHAR = '#-#' ]
          then
             echo $LINE | sed 's/^#-#/   /'
          else
              break
          fi
      fi
      
  done
}

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
