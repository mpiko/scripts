#!/bin/bash


isRunning() {
  local PID=$1
  RUNNING=$(ps ax | grep "^$PID")
  [ -z "$RUNNING" ] && return 1
  return 0
}
