#!/bin/bash
#
# Michael Piko
# Description: 
# Date created:  dd-mm-20yy
# last modified: dd-mm-20yy

#see setEnvironment.sh, functions.sh, and variables.sh for explaination
. setEnvironment.sh

if ! enoughArgs +1 $#
then
  echo "Not enough arguments. Please add comments"
  exit
fi
COMMENTS=$@
set -x
git add .
git commit -m \"$COMMENTS\"
echo "Done. Please run "git push" to update repository"
