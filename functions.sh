#!/bin/bash

# Michael Piko
# commonnly used functions.
# created 222-3-2014

set -o history

# getlogdate
# commonly used in file names
# usage:  LOGFILE=program-$(getlogdate).log
# returns: program-dd-mm-yy.log
function getlogdate() {
   echo $(date +%d-%m-%Y)
}

# Handy to keep track.
# usage: recordscriptrun $HOME/bin/script.sh $HOME/log
function recordscriptrun() {
     local CALLER=$1
     local LOGBASE=$2
     local LOGFILE=logrecord.txt
     local LASTRUN=$(date)
     echo "$CALLER was last run at $LASTRUN" >> $LOGBASE/$LOGFILE

}

# for trimming log files etc.
# usage: trimtail $HOME/log/logfile.log 100
# will trim and retain the last 100 lines of the file
function trimtail() {
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


# cleandir
# This function need to know the directory and the retention time in days. 
# usage:  cleandir /dir/path 4
# removes file older than 4 days from the /dir/path directory
function cleandir() {
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
        find $__dir -mtime +$__retaindays | xargs rm -f
    else
        echo cleandir - directory does not exist
    fi
}

GSIZELIMIT=10
# make the path if it does not exit.
function buildpath() {
   [ -d $1 ] || mkdir -p $1
}


function getlastcommand() {
    echo $(history |tail -n2 |head -n1 | sed 's/[0-9]* //')
}



# testing return code are often ignored. Might try to make it simpler.
function killiflastfailed() {
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

function warniflastfailed() {
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

# remove those vi swap files that get left around.
function remove_swaps() {
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

# similar to remove swaps but for mac poop.
function remove_ds_Store() {
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

# test to see if a value is a number or not
# usage if isNumber $VAR
# returns 0 (true) if it is a number
function isNumber() {
  local NUMB=$(echo $1 | sed 's/^[^0-9]*//g')
  if [ $NUMB ]
  then
    return 0
  else
    return 1
  fi
}

# Yep, should have used a case statment
# returns the number of the month
function getMonthNum() {
   local MONTHNAME=$1
   [ $MONTHNAME = "January" ] && echo 1
   [ $MONTHNAME = "February" ] && echo 2
   [ $MONTHNAME = "March" ] && echo 3
   [ $MONTHNAME = "April" ] && echo 4
   [ $MONTHNAME = "May" ] && echo 5
   [ $MONTHNAME = "June" ] && echo 6
   [ $MONTHNAME = "July" ] && echo 7
   [ $MONTHNAME = "August" ] && echo 8
   [ $MONTHNAME = "September" ] && echo 9
   [ $MONTHNAME = "October" ] && echo 10
   [ $MONTHNAME = "November" ] && echo 11
   [ $MONTHNAME = "December" ] && echo 12
   [ $MONTHNAME = "Jan" ] && echo 1
   [ $MONTHNAME = "Feb" ] && echo 2
   [ $MONTHNAME = "Mar" ] && echo 3
   [ $MONTHNAME = "Apr" ] && echo 4
   [ $MONTHNAME = "May" ] && echo 5
   [ $MONTHNAME = "Jun" ] && echo 6
   [ $MONTHNAME = "Jul" ] && echo 7
   [ $MONTHNAME = "Aug" ] && echo 8
   [ $MONTHNAME = "Sep" ] && echo 9
   [ $MONTHNAME = "Oct" ] && echo 10
   [ $MONTHNAME = "Nov" ] && echo 11
   [ $MONTHNAME = "Dec" ] && echo 12
}

# returns the full name of the month
function getLongMonthName() {
   local MONTHNUM=$1
   [ $MONTHNUM -eq 1 ] && echo "January"
   [ $MONTHNUM -eq 2 ] && echo "February"
   [ $MONTHNUM -eq 3 ] && echo "March"
   [ $MONTHNUM -eq 4 ] && echo "April"
   [ $MONTHNUM -eq 5 ] && echo "May"
   [ $MONTHNUM -eq 6 ] && echo "June"
   [ $MONTHNUM -eq 7 ] && echo "July"
   [ $MONTHNUM -eq 8 ] && echo "August"
   [ $MONTHNUM -eq 9 ] && echo "September"
   [ $MONTHNUM -eq 10 ] && echo "October"
   [ $MONTHNUM -eq 11 ] && echo "November"
   [ $MONTHNUM -eq 12 ] && echo "December"
}

# returns the short name of the month
function getShortMonthName() {
   local MONTHNUM=$1
   [ $MONTHNUM -eq 1 ] && echo "Jan"
   [ $MONTHNUM -eq 2 ] && echo "Feb"
   [ $MONTHNUM -eq 3 ] && echo "Mar"
   [ $MONTHNUM -eq 4 ] && echo "Apr"
   [ $MONTHNUM -eq 5 ] && echo "May"
   [ $MONTHNUM -eq 6 ] && echo "Jun"
   [ $MONTHNUM -eq 7 ] && echo "Jul"
   [ $MONTHNUM -eq 8 ] && echo "Aug"
   [ $MONTHNUM -eq 9 ] && echo "Sep"
   [ $MONTHNUM -eq 10 ] && echo "Oct"
   [ $MONTHNUM -eq 11 ] && echo "Nov"
   [ $MONTHNUM -eq 12 ] && echo "Dec"
}

# ask a question and test the response
# Usage: if askyesNo "question?"
# default is no.
function askyesNo() {
  local QUESTION=$1
  local RESPONSE=""

  echo -n "$QUESTION (y/N) "
  read RESPONSE
  if [ -z $RESPONSE ] 
  then
    RESPONSE="N"
  fi

  if [ $RESPONSE = 'y' ] || [ $RESPONSE = 'Y' ]
  then
    return 0
  else
    return 1
  fi
}


# ask a question and test the response
# Usage: if askYesno "question?"
# default is yes.
function askYesno() {
  local QUESTION=$1
  local RESPONSE=""

  echo -n "$QUESTION (Y/n) "
  read RESPONSE
  if [ -z $RESPONSE ] 
  then
    RESPONSE="y"
  fi

  if [ $RESPONSE = 'y' ] || [ $RESPONSE = 'Y' ]
  then
    return 0
  else
    return 1
  fi
}

