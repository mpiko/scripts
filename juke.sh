#!/bin/bash

cd ~/Desktop

START="http://emit-media-production.s3.amazonaws.com/pbs/the-juke-joint"

END="1300_the-juke-joint_64.m4a"

DAY=$(date --date='last sun' '+%d')
MON=$(date --date='last sun' '+%m')
YEAR=$(date --date='last sun' '+%Y')
Y=$(date --date='last sun' '+%y')


URL="$START/$YEAR/$MON/$DAY/1300/$YEAR$MON$DAY$END"

if [ -e $YEAR$MON$DAY$END ]
then
    echo $YEAR$MON$DAY$END already exists
    exit
elif [ -e JJ-$DAY-$MON-$Y.m4a ]
then
    echo JJ-$DAY-$MON-$Y.m4a already exits
    exit
fi

echo $URL
wget -c $URL

mv $YEAR$MON$DAY$END JJ-$DAY-$MON-$Y.m4a
