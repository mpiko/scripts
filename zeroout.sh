#!/bin/bash
# Michael Piko (michael@cyder.com.au)

# zero out unused parts of a disk. Very handy for compressing the disk
# for compressing and transferring virtual machines around. 
# also, some security protection as removing files does not wipe then
# from the disk.
# Leave a bit of space so we dont blow out the drive space.
# change to the % you would like to keep as headroom.
# We are restricted to working with integers as some shells do not support
# floats.

# CHANGE HERE for the requried % of head room
PERCENTAGE=5

#--------------------------------------------------------

AVAIL=$(df / | tail -1 | gawk '{print $4}')

#sudo mkdir /tmpdd
#cd /tmpdd

echo Free Space: $AVAIL
SIZE=$(($AVAIL - ($AVAIL / 100 * $PERCENTAGE)))
#echo $SIZE


echo dd if=/dev/zero of=dump.$$ bs=1k count=$SIZE status=progress
#sudo dd if=/dev/zero of=dump.$$ bs=1k count=$SIZE status=progress

#sudo rm -rf /tmpdd
