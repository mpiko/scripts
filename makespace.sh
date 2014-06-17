#!/bin/bash


# a script for pop off the oldest files from the recordedtv directory
# if the filesystem is above MINPERCENT then it starts to delete the
# oldest files first until it get below the threshold.

#
# Michael Piko
# Description: 
# Date created:  17-06-2014
# last modified: dd-mm-20yy

#see setEnvironment.sh, functions.sh, and variables.sh for explaination
. setEnvironment.sh

buildpath $LOGDIR
cleandir $LOGDIR 2
recordscriptrun $(basename $0) $LOGBASE

MINPERCENT=90

cd /home/hts/recordedtv

PERCENTAGE=$(df 2> /dev/null | grep sda1 | sed 's/ \+/-/g' | cut -f5 -d- | sed 's/%//')


while [ $PERCENTAGE -gt $MINPERCENT ]
do
   OLDESTFILE=$(ls -1t | tail  -1)
   echo "$OLDESTFILE  $PERCENTAGE" >> $LOGFILE
   rm "$OLDESTFILE"
   PERCENTAGE=$(df 2> /dev/null | grep sda1 | sed 's/ \+/-/g' | cut -f5 -d- | sed 's/%//')
done
