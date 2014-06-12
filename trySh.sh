#!/bin/bash

. setEnvironment.sh
if isHostUp ltp
then
  echo All good
else
  echo "Not found"
fi
