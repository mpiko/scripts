#!/bin/bash -x


isRunning() {
  local PID=$1
  [ -z $PID ] && return 1
  local RUNNING=$(ps ax | grep "^$PID" | cut -f1 -d" ")
  [ -z "$RUNNING" ] && return 1
  return 0
}
