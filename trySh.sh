#!/bin/bash

. setEnvironment.sh

MONTH="July"
NUM=$(getMonthNum $MONTH)

echo $MONTH is $NUM

for i in 1 2 3 4 5 6 7 8 9 10 11 12
do
   LNAME=$(getLongMonthName $i)
   SNAME=$(getShortMonthName $i)
   echo "$LNAME $SNAME $i"
done
