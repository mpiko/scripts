#!/bin/bash

. setEnvironment.sh


LOGBASE=$HOME/log
recordscriptrun $(basename $0) $LOGBASE

rsync -ave ssh /home/michael/.thunderbird ltsp:/home/michael/
