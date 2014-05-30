#!/bin/bash

. setEnvironment.sh

buildpath $LOGDIR
cleandir $LOGDIR 2
recordscriptrun $(basename $0) $LOGBASE


remove_swaps $HOME > $LOGFILE
remove_ds_Store $HOME >> $LOGFILE
remove_Thumbs $HOME >> $LOGFILE
