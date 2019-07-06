#!/bin/bash


rsync --delete -ae ssh root@www.valavon.com.au:/home/backup/ /home/backup_val/
