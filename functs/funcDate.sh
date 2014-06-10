#!/bin/bash

# getlogdate
# commonly used in file names
# usage:  LOGFILE=program-$(getlogdate).log
# returns: program-dd-mm-yy.log
getlogdate() {
   echo $(date +%d-%m-%Y)
}

getdate() {
   echo $(date +%d-%m-%Y)

}
getTime() {
   echo $(date +%H-%M-%S)
}

