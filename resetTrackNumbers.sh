#!/bin/bash

INC=0
for i in $(ls -1 *.mp3)
do
  INC=$(expr $INC + 1)
  DAY=$(echo $i | cut -f2 -d-)
  MONNUM=$(echo $i | cut -f3 -d-)
  array[$INC]=$DAY
done
readarray -t sorted < <(printf '%s\n' "${array[@]}" | sort -n | xargs -0n1)

INC=0
for a in "${sorted[@]}"
do
  INC=$(expr $INC + 1)
  if [ $a ]
  then
    FILE=$(ls *-$a-$MONNUM-14*.mp3)
    id3v2 -T $INC $FILE
  fi
done
