#!/bin/bash

cd ~/Desktop

START="http://emit-media-production.s3.amazonaws.com/pbs/the-juke-joint"

END="1300_the-juke-joint_64.m4a"

DAY=$(date --date='last sun' '+%d')
MON=$(date --date='last sun' '+%m')
YEAR=$(date --date='last sun' '+%Y')
Y=$(date --date='last sun' '+%y')
URL="$START/$YEAR/$MON/$DAY/1300/$YEAR$MON$DAY$END"
D=$(date +%W)
D=$(calc $D -1| sed 's/\t\+//g')
if [ $D -lt 10 ]
then
    D=0$D
else
    D=$D
fi

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

mv $YEAR$MON$DAY$END JJ-${DAY}-${MON}-$Y.m4a

soundconverter -b -m "audio/mpeg" -s ".mp3" JJ-${DAY}-${MON}-$Y.m4a
if [ $? -eq 0 ]
then
    echo "converstion complete"
    rm JJ-${DAY}-${MON}-$Y.m4a
else
    echo "Conversaion failed"
fi

mid3v2 -A "Juke Joint" -t "${DAY}-${MON}-$Y" -a "Matt Fredricks" -T $D JJ-${DAY}-${MON}-$Y.mp3



