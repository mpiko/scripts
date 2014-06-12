#!/bin/bash

askYesno() {
# Usage: if askYesno "question?"
# y = true (default)
# n = false
  local QUESTION=$1
  local RESPONSE="FAKE"

  while [ $RESPONSE = 'FAKE' ]
  do
    echo -n "$QUESTION (Y/n) "
    read RESPONSE
    if [ -z $RESPONSE ] 
    then
      RESPONSE="Y"
    fi

    RESPONSE=$(upper $RESPONSE)

    if [ $RESPONSE = 'Y' ]
    then
      return 0
    elif [ $RESPONSE = 'N' ]
    then
      return 1
    else
      RESPONSE="FAKE"
      echo "Invalid response"
    fi
  done
}

askyesNo() {
# Usage: if askyesNo "question?"
# y = true
# n = false (default)
  local QUESTION=$1
  local RESPONSE="FAKE"

  while [ $RESPONSE = 'FAKE' ]
  do
    echo -n "$QUESTION (y/N) "
    read RESPONSE
    if [ -z $RESPONSE ] 
    then
      RESPONSE="N"
    fi

    RESPONSE=$(upper $RESPONSE)

    if [ $RESPONSE = 'Y' ]
    then
      return 0
    elif [ $RESPONSE = 'N' ]
    then
      return 1
    else
      RESPONSE="FAKE"
      echo "Invalid response"
    fi
  done
}

askyesNoquit() {
# y = true
# n = false (default)
# q = exit
# quiting will exit the program completely.
  local QUESTION=$1
  local RESPONSE="FAKE"

  while [ $RESPONSE = 'FAKE' ]
  do
    echo -n "$QUESTION (y/N/q) "
    read RESPONSE
    if [ -z $RESPONSE ] 
    then
      RESPONSE="N"
    fi
    RESPONSE=$(upper $RESPONSE)
  
   if [ $RESPONSE = 'Y' ]
    then
      return 0
    elif [ $RESPONSE = 'N' ]
    then
      return 1
    elif [ $RESPONSE = 'Q' ]
    then
      exit 5
    else
      RESPONSE="FAKE"
      echo "Invalid response"
    fi
  done
}
askYesnoquit() {
# y = true (default)
# n = false
# q = exit
# quiting will exit the program completely.
  local QUESTION=$1
  local RESPONSE="FAKE"

  while [ $RESPONSE = 'FAKE' ]
  do
    echo -n "$QUESTION (Y/n/q) "
    read RESPONSE
    if [ -z $RESPONSE ] 
    then
      RESPONSE="Y"
    fi
    RESPONSE=$(upper $RESPONSE)
  
   if [ $RESPONSE = 'Y' ]
    then
      return 0
    elif [ $RESPONSE = 'N' ]
    then
      return 1
    elif [ $RESPONSE = 'Q' ]
    then
      exit 5
    else
      RESPONSE="FAKE"
      echo "Invalid response"
    fi
  done
}
