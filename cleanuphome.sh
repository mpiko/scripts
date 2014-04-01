#!/bin/bash

. setEnvironment.sh

buildpath $LOGDIR
cleandir $LOGDIR 2
recordscriptrun $(basename $0) $LOGBASE


remove_swaps $HOME > $LOGFILE
