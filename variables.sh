#!/bin/bash

. .secrets

LOGBASE=$HOME/log
LOGDIR=$LOGBASE/$(basename $0)
LOGFILE=$LOGDIR/$(basename $0)-$(getlogdate).log
