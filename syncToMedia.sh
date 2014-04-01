#!/bin/bash

. setEnvironment.sh

buildpath $LOGDIR
recordscriptrun $(basename $0) $LOGBASE

cd

rsync -ave ssh Downloads/sync/ media@media-laptop:Downloads/sync/ > $LOGFILE
mv Downloads/sync/* Downloads/complete/

cleandir Downloads/complete 4

