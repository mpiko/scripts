#!/bin/bash

export DISPLAY=:0


# sudo apt-get install python-mutagen soundconverter apcalc wget
# Note: python-mutagen contains mid3v2

DAY=$(date --date='last tue' '+%d')
MON=$(date --date='last tue' '+%m')
YEAR=$(date --date='last tue' '+%Y')
Y=$(date --date='last tue' '+%y')

WORKDIR=~/Desktop
cd $WORKDIR

# where to put the file when done.
if [ $HOSTNAME == "avon" ]
then
    DEST=/medback/PBS/GTB/$YEAR/$MON/
else
    DEST=~/Desktop
fi

[ -e $DEST ] || mkdir $DEST

if [ -e $DEST/GTB-${DAY}-${MON}-$Y.mp3 ]
then
    #echo Nothing to do.
    exit
fi

echo Saving to $DEST

# Complete the URL
START="http://emit-media-production.s3.amazonaws.com/pbs/got-the-blues"
END="0200_got-the-blues_64.m4a"
URL="$START/$YEAR/$MON/$DAY/0200/$YEAR$MON$DAY$END"

# numerical week of the year
D=$(date +%W)
D=$(calc $D -1| sed 's/\t\+//g')
# add leading 0 if below 10
if [ $D -lt 10 ]
then
    D=0$D
fi

# GTB is only one every second week. We need to check to see if it is the correct week.
if [ $(calc $D \/ 2 | grep "\.") ]
then
    # its an odd numbered week. GTB is only broadcast on even weeks.
    exit
fi

# housekeeping. bail if the file already exists.
if [ -e $YEAR$MON$DAY$END ]
then
    echo $YEAR$MON$DAY$END already exists
    exit
elif [ -e GTB-$DAY-$MON-$Y.m4a ]
then
    echo GTB-$DAY-$MON-$Y.m4a already exits
    exit
fi

#echo $URL
# get this weeks episode
wget -c $URL

# rename the file
mv $YEAR$MON$DAY$END GTB-${DAY}-${MON}-$Y.m4a

# convert the file from mp4 to mp3
soundconverter -b -m "audio/mpeg" -s ".mp3" GTB-${DAY}-${MON}-$Y.m4a
if [ $? -eq 0 ]
then
    echo "converstion complete"
    rm GTB-${DAY}-${MON}-$Y.m4a
else
    echo "Conversaion failed"
fi

# add the id tags to the mp3
mid3v2 -A "Juke Joint" -t "${DAY}-${MON}-$Y" -a "Andy Merkel" -T $D GTB-${DAY}-${MON}-$Y.mp3

# Move the file to its destination
[ -d $DEST ] || mkdir -p $DEST
if [ ! $DEST == $WORKDIR ]
then
    mv GTB-${DAY}-${MON}-$Y.mp3 $DEST
fi

