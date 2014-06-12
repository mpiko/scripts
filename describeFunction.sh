#!/bin/bash
#
# Michael Piko
# Description: 
# Date created:  dd-mm-20yy
# last modified: dd-mm-20yy

#see setEnvironment.sh, functions.sh, and variables.sh for explaination
. setEnvironment.sh

buildpath $LOGDIR
cleandir $LOGDIR 2
recordscriptrun $(basename $0) $LOGBASE

dieIfNotEnoughArgs 1 $#

FINDFUNC=$1
OLDIFS=$IFS
IFS="
"

for LINE in $(grep '() ' $HOME/bin/functs/func*.sh | cut -f1 -d\( | grep "$FINDFUNC")
do
  TMPFUNCTION=$(echo $LINE | cut -f2 -d:)
  if [ $FINDFUNC = $TMPFUNCTION ]
  then
    FOUND="TRUE"
    FUNCTION=$TMPFUNCTION
    FILEPATH=$(echo $LINE | cut -f1 -d:)
    FILE=$(basename $FILEPATH)
    echo FUNCTON NAME: $FUNCTION
    echo LOCATION: $FILE
  fi
done
if [ -z $FOUND ]
then
   echo "Could not find function: $FINDFUNC"
   exit
fi


FOUND="FALSE"
for LINE in $(cat $HOME/bin/functs/$FILE)
do
    if [ $FOUND = "TRUE" ]
    then
        CHAR=$(echo $LINE | cut -c1)
        if [ $CHAR = '#' ]
        then
           echo $LINE | sed 's/^#/  /'
        else
            FOUND="FALSE"
        fi
    fi
    
    TMP=$(echo $LINE | grep "^$FUNCTION(")
    if [ ! -z $TMP ]
    then
       FOUND="TRUE"
    fi
done
