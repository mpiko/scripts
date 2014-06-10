#!/bin/bash

. setEnvironment.sh

PID=$(cat /tmp/constantMirror.sh.lock)
if isRunning $PID
then
  echo PID=$PID running
else
  echo Not running
fi

