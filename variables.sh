#!/bin/bash

. .secrets

ME=$(basename $0)

LOGBASE=$HOME/.log
LOGDIR=$LOGBASE/$(basename $0)
LOGFILE=$LOGDIR/$(basename $0)_$(getDate)_$(getTime).log
case $- in
  *i*)    # interactive shell
       INTERACTIVE=true
        ;;
    *)      # non-interactive shell
        ;;
esac
