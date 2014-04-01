#!/bin/bash

. functions.sh

LOGBASE=$HOME/log

recordscriptrun $(basename $0) $LOGBASE

trimtail $LOGBASE/logrecord.txt 100
