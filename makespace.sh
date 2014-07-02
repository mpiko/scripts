#!/bin/bash


#
# Michael Piko
# Description: 
# Date created:  17-06-2014
# last modified: 18-06-2014

# a script for pop off the oldest files from the recordedtv directory
# if the filesystem is above the value set in $TRIGGER. It then it starts to delete the
# oldest files first until it get down to below the threshold set in $TARGET.

#see setEnvironment.sh, functions.sh, and variables.sh for explaination
. setEnvironment.sh

# Variables:
# These values are percentages. The trigger must be greater or equal to the target.
TRIGGER=90
TARGET=85
DIR=/home/hts/recordedtv

buildpath $LOGDIR
cleandir $LOGDIR 2
recordscriptrun $(basename $0) $LOGBASE

if [ $TARGET -gt $TRIGGER ]
then
   echo "Trigger ($TRIGGER) must be greater or equal to the target ($TARGET)"
   exit 1
fi

VERBOSE=n
if [ $# -eq 1 ] && [ $1 = "-v" ]
then
  VERBOSE=y
fi


cd $DIR

# get the percentage used from df
USEDSPACE=$(df 2> /dev/null | grep sda1 | sed 's/ \+/-/g' | cut -f5 -d- | sed 's/%//')

GO="FALSE"
if [ $USEDSPACE -ge $TRIGGER ]
then
   GO="TRUE"
   onScreen $VERBOSE "USED = ${USEDSPACE}%, Threshold = ${TRIGGER}%. Beginning removal from $DIR"
   echo "USED = ${USEDSPACE}%, Target = ${TARGET}%. Beginning removal from $DIR" >> $LOGFILE
else
   onScreen $VERBOSE "USED = ${USEDSPACE}%, Threshold = ${TRIGGER}%. Nothing to do!"
fi
while [ $USEDSPACE -gt $TARGET ] && [ $GO = "TRUE" ]
do
   OLDESTFILE=$(ls -1t *.mkv | tail  -1)
   onScreen $VERBOSE "$USEDSPACE: removing $OLDESTFILE"
   echo "$USEDSPACE: removing $OLDESTFILE" >> $LOGFILE
   #rm "$OLDESTFILE"
   sudo rm "$OLDESTFILE"
   USEDSPACE=$(df 2> /dev/null | grep sda1 | sed 's/ \+/-/g' | cut -f5 -d- | sed 's/%//')
  # read STUFF
done

