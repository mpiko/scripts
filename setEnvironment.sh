#!/bin/bash

# pull in all the global functions
for i in $(ls -1 $HOME/bin/functs/func*.sh)
do
  if [ -x $i ]
  then
    . $i
  else
    echo "WARNING: $i is not executable"
  fi
done  

# import all the global variables
. variables.sh


