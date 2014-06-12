#!/bin/bash

getlogdate() {
# getlogdate
# commonly used in file names
# usage:  LOGFILE=program-$(getlogdate).log
# returns: program-dd-mm-yy.log
   echo $(date +%d-%m-%Y)
}

getDate() {
# getDate
# commonly used in file names
# Example:  LOGFILE=program-$(getDate).log
# returns: program-dd-mm-yy.log
   echo $(date +%d-%m-%Y)

}
getTime() {
# returns hh-mm-ss
# Example: FILE=program-date-$(getTime).txt
   echo $(date +%H-%M-%S)
}


getMonthNum() {
# returns the number of the month
# Example: MONNUM=$(getMonthNum Jan)
   local MONTHNAME=$1
   case $MONTHNAME in
       January) echo 1 ;;
       February) echo 2 ;;
       March) echo 3 ;;
       April) echo 4 ;;
       May) echo 5 ;;
       June) echo 6 ;;
       July)  echo 7 ;;
       August)  echo 8 ;;
       September)  echo 9 ;;
       October)  echo 10 ;;
       November)  echo 11 ;;
       December)  echo 12 ;;
       Jan)  echo 1 ;;
       Feb)  echo 2 ;;
       Mar)  echo 3 ;;
       Apr)  echo 4 ;;
       May)  echo 5 ;;
       Jun)  echo 6 ;;
       Jul)  echo 7 ;;
       Aug)  echo 8 ;;
       Sep)  echo 9 ;;
       Oct)  echo 10 ;;
       Nov)  echo 11 ;;
       Dec)  echo 12 ;;
       *) echo "not found"
   esac
}

getLongMonthName() {
# returns the full name of the month
# example: MONTH=$(getLongMonthName 3)
#          $MONTH will contain "March"
   local MONTHNUM=$1
   case $MONTHNUM in
       1) echo "January" ;;
       2) echo "February" ;;
       3) echo "March" ;;
       4) echo "April" ;;
       5) echo "May" ;;
       6) echo "June" ;;
       7) echo "July" ;;
       8) echo "August" ;;
       9) echo "September" ;;
       10) echo "October" ;;
       11) echo "November" ;;
       12) echo "December" ;;
       *) echo "not found"
   esac
}

getShortMonthName() {
# returns the short name of the month
# example: MONTH=$(getShortMonthName 3)
#          $MONTH will contain "Mar"
   local MONTHNUM=$1
   case $MONTHNUM in
       1) echo "Jan" ;;
       2) echo "Feb" ;;
       3) echo "Mar" ;;
       4) echo "Apr" ;;
       5) echo "May" ;;
       6) echo "Jun" ;;
       7) echo "Jul" ;;
       8) echo "Aug" ;;
       9) echo "Sep" ;;
       10) echo "Oct" ;;
       11) echo "Nov" ;;
       12) echo "Dec" ;;
       *) echo "not found"
   esac
}
