#!/bin/bash
IFS="
"

for LINE in $(grep '() ' $HOME/bin/functs/func*.sh | cut -f1 -d\( )
do
  FUNCTION=$(echo $LINE | cut -f2 -d:)
  FILEPATH=$(echo $LINE | cut -f1 -d:)
  FILE=$(basename $FILEPATH)
  echo $FILE $FUNCTION
done
