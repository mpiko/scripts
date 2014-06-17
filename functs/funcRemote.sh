#!/bin/bash

isHostUp() {
# Tests to see if a host is up. Handy to check before trying to contact
# the remote machine
# Should 2 pings to the remote machine fail, then another 4 are sent.
# Usage: if isHostUp server1; then...
  local RHOST=$1
  # check for the user@host and strip the host part out
  RHOST=$(echo $RHOST | cut -f2 -d@)
  ping -c 2 $RHOST > /dev/null 2>&1
  if [ $? -ne 0 ]
  then
    ping -c 4 $RHOST > /dev/null 2>&1
    if [ $? -ne 0 ]
    then
      return 1
    fi
  fi
  return 0
}
