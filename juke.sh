#!/bin/bash

export DISPLAY=:0

cd ~/Desktop

# sudo apt-get install python-mutagen soundconverter apcalc wget
# Note: python-mutagen contains mid3v2

DAY=$(date --date='last sun' '+%d')
MON=$(date --date='last sun' '+%m')
YEAR=$(date --date='last sun' '+%Y')
Y=$(date --date='last sun' '+%y')


# where to put the file when done.
if [ $HOSTNAME == "avon" ]
then
    DEST=/media/michael/medback/PBS/JJ/$YEAR/$MON/
else
    DEST=~/Desktop
fi

echo Saving to $DEST


# Complete the URL
START="http://emit-media-production.s3.amazonaws.com/pbs/the-juke-joint"
END="1300_the-juke-joint_64.m4a"
URL="$START/$YEAR/$MON/$DAY/1300/$YEAR$MON$DAY$END"

# numerical week of the year
D=$(date +%W)
D=$(calc $D -1| sed 's/\t\+//g')
# add leading 0 if below 10
if [ $D -lt 10 ]
then
    D=0$D
fi

# housekeeping. bail if the file already exists.
if [ -e $YEAR$MON$DAY$END ]
then
    echo $YEAR$MON$DAY$END already exists
    exit
elif [ -e JJ-$DAY-$MON-$Y.m4a ]
then
    echo JJ-$DAY-$MON-$Y.m4a already exits
    exit
fi

#echo $URL
# get this weeks episode
wget -c $URL

# rename the file
mv $YEAR$MON$DAY$END JJ-${DAY}-${MON}-$Y.m4a

# convert the file from mp4 to mp3
soundconverter -b -m "audio/mpeg" -s ".mp3" JJ-${DAY}-${MON}-$Y.m4a
if [ $? -eq 0 ]
then
    echo "converstion complete"
    rm JJ-${DAY}-${MON}-$Y.m4a
else
    echo "Conversaion failed"
fi

# add the id tags to the mp3
mid3v2 -A "Juke Joint" -t "${DAY}-${MON}-$Y" -a "Matt Fredricks" -T $D JJ-${DAY}-${MON}-$Y.mp3

# Move the file to its destination
[ -d $DEST ] || mkdir -p $DEST
mv JJ-${DAY}-${MON}-$Y.mp3 $DEST

