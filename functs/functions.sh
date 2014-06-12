#!/bin/bash

# Michael Piko
# commonnly used functions.
# created 222-3-2014

set -o history

recordscriptrun() {
# Handy to keep track.
# usage: recordscriptrun $HOME/bin/script.sh $HOME/log
     local CALLER=$1
     local LOGBASE=$2
     local LOGFILE=logrecord.txt
     local LASTRUN=$(date)
     echo "$CALLER was last run at $LASTRUN" >> $LOGBASE/$LOGFILE

}

trimtail() {
# for trimming log files etc.
# usage: trimtail $HOME/log/logfile.log 100
# will trim and retain the last 100 lines of the file
    local FILE=$1
    local BASEFILE=$(basename $1)
    local SIZELIMIT=$2
    local CSIZE="0"

    if [ -e $FILE ]
    then
        CSIZE=`wc -l $FILE | cut -f1 -d" "`
        if [ $CSIZE -gt $SIZELIMIT ]
        then
            cp $FILE /tmp/$BASEFILE.tmp
            tail -$SIZELIMIT /tmp/$BASEFILE.tmp > $FILE
            rm /tmp/$BASEFILE.tmp
         fi
    else
        echo "could not find $FILE to trim"
    fi

}


cleandir() {
# cleandir
# This function need to know the directory and the retention time in days. 
# usage:  cleandir /dir/path 4
# removes file older than 4 days from the /dir/path directory
    local  __dir=$1
    local  __retaindays=$2
    [ -z $__dir ] && {
        echo cleandir - dir arguments missing
        return 1
    }
    [ -z $__retaindays ] && {
        echo cleandir - retention arguments missing
        return 1
    }

    if [ -d $__dir ] 
    then
        find $__dir/ -mtime +$__retaindays | xargs rm -f
    else
        echo cleandir - directory does not exist
    fi
}

buildpath() {
# make the path if it does not exit.
   [ -d $1 ] || mkdir -p $1
}


getlastcommand() {
    echo $(history |tail -n2 |head -n1 | sed 's/[0-9]* //')
}



killiflastfailed() {
# testing return code are often ignored. Might try to make it simpler.
   local __retval=$1
   if [ $__retval -gt 0 ] 
   then 
   #   echo Last command failed
      LAST=`history |tail -n2 |head -n1 | sed 's/[0-9]*//g'| sed 's/^ *//'`
      echo TERMINATED: $LAST failed
      exit 6
   #else
   #   echo Last command good!
   fi
}

warniflastfailed() {
   local __retval=$1
   if [ $__retval -gt 0 ] 
   then 
      LAST=`history |tail -n2 |head -n1 | sed 's/[0-9]*//g'| sed 's/^ *//'`
      echo WARNING: $LAST failed
      return 6
   #else
   #   echo Last command good!
   fi
}

remove_swaps() {
# remove those vi swap files that get left around.
    __dir=$1
    if [ -d $__dir ] 
    then
        FOUND=$(find $__dir -name '*~')
        IFS="
"
        for i in $FOUND
        do
            echo removed $i
            rm $i
        done
    else
        echo Cannot find $__dir to clean
        return 1
    fi
}

remove_ds_Store() {
# similar to remove swaps but for mac poop.
    __dir=$1
    if [ -d $__dir ] 
    then
        FOUND=$(find $__dir -name '.DS_Store')
        IFS="
"
        for i in $FOUND
        do
            echo removed $i
            rm $i
        done
    else
        echo Cannot find $__dir to clean
        return 1
    fi
}

remove_Thumbs () {
    __dir=$1
    if [ -d $__dir ] 
    then
        FOUND=$(find $__dir -name 'Thumbs.db')
        IFS="
"
        for i in $FOUND
        do
            echo removed $i
            rm $i
        done
    else
        echo Cannot find $__dir to clean
        return 1
    fi
}

isNumber() {
# test to see if a value is a number or not
# usage if isNumber $VAR
# returns 0 (true) if it is a number
  local NUMB=$(echo $1 | sed 's/^[^0-9]*//g')
  if [ $NUMB ]
  then
    return 0
  else
    return 1
  fi
}
isStaleFile() {
# usage: checkStaleFile file 60 
# would return true if file is older than 60 seconds
  local LIMIT=$2
  local RAWTIME=$(date +"%s")
  local CHANGEDTIME=$(stat --printf=%Z "$1")
  local TIMEDELTA=$(expr $RAWTIME - $CHANGEDTIME)
  if [ $TIMEDELTA -gt $LIMIT ]
  then
    return 0
  else
    return 1
  fi 
}
