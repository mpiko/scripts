
#===================================================================
# UNDER DEVELOPMENT - DO NOT USE IN PRODUCTION
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

function remove_swaps() {
    __dir=$1
    if [ -d $__dir ] 
    then
        FOUND=$(find $__dir -name '*~')
        IFS="
"
        for i in $FOUND
        do
            echo removing $i
            rm $i
        done
    else
        echo Cannot find $__dir to clean
        return 1
    fi
}
