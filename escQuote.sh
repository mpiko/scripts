#!/bin/bash

LEN=$(echo $1 | wc -c)
COUNTER=1

while [ $COUNTER -lt $LEN ]
do
   CHAR=$(echo $1 | cut -b$COUNTER )
   if [ $CHAR == "'" ]
   then
     WORD="${WORD}\\${CHAR}"
   else
     WORD="$WORD$CHAR"
   fi
   COUNTER=$(expr $COUNTER + 1)
done
echo $WORD
