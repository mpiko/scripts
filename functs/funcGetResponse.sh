#!/bin/bash

# ask a question and test the response
# Usage: if askyesNo "question?"
# default is no.
askyesNo() {
  local QUESTION=$1
  local RESPONSE=""

  echo -n "$QUESTION (y/N) "
  read RESPONSE
  if [ -z $RESPONSE ] 
  then
    RESPONSE="N"
  fi

  if [ $RESPONSE = 'y' ] || [ $RESPONSE = 'Y' ]
  then
    return 1
  else
    return 0
  fi
}


# ask a question and test the response
# Usage: if askYesno "question?"
# default is yes.
askYesno() {
  local QUESTION=$1
  local RESPONSE=""

  echo -n "$QUESTION (Y/n) "
  read RESPONSE
  if [ -z $RESPONSE ] 
  then
    RESPONSE="y"
  fi

  if [ $RESPONSE = 'y' ] || [ $RESPONSE = 'Y' ]
  then
    return 0
  else
    return 1
  fi
}

askyesnoquit() {
# y = true
# n = false
# q = exit
# quiting will exit the program completely.
  local QUESTION=$1
  local RESPONSE=""

  echo -n "$QUESTION (y/n/q) "
  read RESPONSE
  if [ -z $RESPONSE ] 
  then
    RESPONSE="N"
  fi
  
  if [ $RESPONSE = 'q' ] || [ $RESPONSE = 'Q' ]
  then
     exit 5
  fi

  if [ $RESPONSE = 'y' ] || [ $RESPONSE = 'Y' ]
  then
    return 0
  fi
  return 1
}
