#!/bin/bash
#
# Michael Piko
# Description: 
# Date created:  13-06-2014
# last modified: dd-mm-20yy

#see setEnvironment.sh, functions.sh, and variables.sh for explaination
. setEnvironment.sh

if ! enoughArgs 1 $#
then
  echo "Usage: $ME newscript"
  exit 1
fi
NEWFILE=$1
CDATE=$(getDate)
if [ -e $NEWFILE ]
then
   if ! askyesNoquit "$NEWFILE already exists. Overwrite?"
   then
     echo "Aborting"
     exit
  fi
  echo "Overwriting"
fi

cat ~/bin/skel.txt | sed "s/CDD-CMM-C20YY/$CDATE/" > $NEWFILE

chmod 755 $NEWFILE
echo $NEWFILE is now ready.
