#!/bin/bash
clear
while true
do
    for i in *S??E??*.mp4
    do
        checkdownload "$i"; 
    done
    sleep 2
    clear
done
