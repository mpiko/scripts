#!/bin/bash

. setEnvironment.sh

buildpath $LOGDIR
recordscriptrun $(basename $0) $LOGBASE

cd

rsync -ave ssh 'media@media-laptop:/home/hts/recordedtv/Oz\ Fish*' /home/lawrie --partial > $LOGFILE 
rsync -ave ssh 'media@media-laptop:/home/hts/recordedtv/Australian\ Fishing*' /home/lawrie --partial >> $LOGFILE

sudo chown -R michael.public /home/lawrie

cleandir $LOGDIR 4

