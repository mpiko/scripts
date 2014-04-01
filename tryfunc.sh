#!/bin/bash

#. devfunctions.sh
. setEnvironment.sh
echo "Starting script"

#echo $LOGFILE
#echo $(basename $0)

function isNumber2() {
  #local NUMB=$(echo $1 | sed 's/[^0-9]*//g')
  local NUMB=$1
  local LEN=$(echo $NUMB | wc -c)
  i=1
  while [ $i -lt $LEN ]
  do
    CHAR=$(echo $NUMB | cut -c$i)
    i=$(expr $i + 1)
    echo $CHAR
    NUMB=$(echo $CHAR | sed 's/[^0-9]*//g')
    echo $NUMB
    if [ $CHAR -eq /0-9/ ]
    then
       :
    else
      return 1
    fi
  done
  return 0
}

NUM=$1
if isNumber2 $NUM
then
   echo $NUM is a number
else
   echo $NUM is not a number
fi


#killiflastfailed $?
#cleanlogs $LOGDIR 5
#warniflastfailed 4
#echo "still going"
#cleanlogs $LOGDIR 5
#killiflastfailed $?

#if [ $# -eq 1 ]
#then
#    echo One found
#else
#    echo not found
#fi

echo closing script
