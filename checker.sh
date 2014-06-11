#!/bin/bash
. setEnvironment.sh


clear
while true
do
    NOW=$(getTime | sed 's/-/:/g')
    echo "Time: $NOW"
    for i in *S??E??*.mp4
    do
        checkdownload "$i"; 
    done
    sleep 2
    clear
done
