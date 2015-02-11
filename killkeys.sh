#!/bin/bash

if [ -z $1 ]
then
    echo "not enough args"
    exit
fi

ssh-keygen -f "/home/michael/.ssh/known_hosts" -R $1
