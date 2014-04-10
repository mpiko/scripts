#!/bin/bash

. setEnvironment.sh

buildpath $LOGDIR
recordscriptrun $(basename $0) $LOGBASE

cd

rsync -ave ssh 'media@media-laptop:/home/hts/recordedtv/Oz\ Fish*' /home/lawrie > $LOGFILE 
rsync -ave ssh 'media@media-laptop:/home/hts/recordedtv/Australian\ Fishing*' /home/lawrie >> $LOGFILE

chown -R michael.public /home/lawrie

cleandir $LOGDIR 4

