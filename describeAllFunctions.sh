#!/bin/bash
#
# Michael Piko
# Description: 
# Date created:  dd-mm-20yy
# last modified: dd-mm-20yy

#see setEnvironment.sh, functions.sh, and variables.sh for explaination
. setEnvironment.sh

for i in $(listFunctions.sh | cut -f2 -d" ")
do 
  describeFunction.sh $i
done
