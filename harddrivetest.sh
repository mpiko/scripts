#!/bin/bash

. setEnvironment.sh

:> test.txt

echo "dd test: 32Gb Class 4 SD card"
if askyesnoquit "Continue?"
then
  echo "" >> test.txt
  echo "dd test: 32Gb Class 4 SD card" >> test.txt
  dd if=/dev/zero of=/tmp/file.img bs=8k count=256k >> test.txt 2>&1
  # 262144+0 records in
  # 262144+0 records out
  # 2147483648 bytes (2.1 GB) copied, 421.43 s, 5.1 MB/s
fi

echo "dd test: 80Gb SATA HDD connnected via USB" 
if askyesnoquit "Continue?"
then
  echo "" >> test.txt
  echo "dd test: 80Gb SATA HDD connnected via USB" >> test.txt
  dd if=/dev/zero of=/media/USBDisk001/file.img bs=8k count=256k >> test.txt 2>&1
  # 262144+0 records in
  # 262144+0 records out
  # 2147483648 bytes (2.1 GB) copied, 80.7888 s, 26.6 MB/s
fi

echo "htparm test: 32Gb Class 4 SD card"
if askyesnoquit "Continue?"
then
  echo "" >> test.txt
  echo "htparm test: 32Gb Class 4 SD card" >> test.txt
  sudo hdparm -tT /dev/mmcblk0p8 >> test.txt
  #/dev/mmcblk0p8:
  # Timing cached reads:   276 MB in  2.00 seconds = 137.85 MB/sec
  # Timing buffered disk reads:  24 MB in  3.07 seconds =   7.81 MB/sec
fi

echo "hdparm test: 80Gb SATA HDD connnected via USB"
if askyesnoquit "Continue?"
then
  echo "" >> test.txt
  echo "hdparm test: 80Gb SATA HDD connnected via USB" >> test.txt
  sudo hdparm -tT /dev/sda1 >> test.txt
  #/dev/sda1:
  # Timing cached reads:   300 MB in  2.01 seconds = 149.35 MB/sec
  # Timing buffered disk reads:  82 MB in  3.01 seconds =  27.24 MB/sec
fi

echo "See test.txt for results"
