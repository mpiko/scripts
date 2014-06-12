#!/bin/bash


onScreen() {
# displays stuff if first argument is a 'y'
# Usage: onScreen y comments
# Example: onScreen y DEBUG: blah blah
#   echos out "DEBUG: blah blah" if there is a 'y' as the first arg

  local OUTPUT=$1
  if [ -z $OUTPUT ]
  then
    return 0
  fi
  if [ $OUTPUT = 'y' ]
  then
    shift
    echo $@
  fi
}
