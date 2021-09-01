#!/bin/bash

if [ $# -ne 1 ]
then
    echo "Usage $0 imagename.img"
    exit 1
fi

[ -e $1 ] || echo "could not $1" && exit 2


START=$(sudo fdisk -l $1 | grep "^$1" | tail -1 | gawk '{print $2}')

echo START=$START
sudo losetup /dev/loop20 $1 -o $(($START*512))

echo "make sure you not the size \"resize2fs -p /dev/loop0 XXXXXK\""
echo "Press enter when ready"
read GO

sudo gparted /dev/loop20

sudo losetup -d /dev/loop20

sudo losetup /dev/loop20 $1 

echo "Resize the partitions using fdisk
Delete the second partition, then regreat using the start and end values
Press enter when ready

NOTE: START=$START"
read GO

sudo fdisk /dev/loop20

END=$(sudo fdisk -l $1 | grep "^$1" | tail -1 | gawk '{print $3}')

sudo truncate -s $((($END+1)*512)) $1

sudo losetup -d /dev/loop20

echo -n "Would you like to gzip $1 (y/N)? "
read ZIP

[ -z $ZIP ] && exit 0

ZIP=$(echo $ZIP | tr '[A_Z]' '[a-z]' | cut -b1)
if [ $ZIP = "y" ]
then
    echo "gzip $1 - please wait"
    gzip $1
fi
