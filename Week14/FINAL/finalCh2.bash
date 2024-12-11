#!/bin/bash

IOCWebpage="10.0.17.6/IOC.html"
logFile="$1"
IOCFile="$2"

function listIOC()
{
 #clearing file we are about to use
 :> report.txt
 :> shortLog.log

 cat "$logFile" | cut -d' ' -f1,4,7 > shortLog.log

 while read -r line
 do
  grep "$line" "shortLog.log" | tr -d [ >> report.txt
done < "$IOCFile"

rm shortLog.log
}

[ $# -ne 2 ] && echo "wrong number of arguments" && exit 2

listIOC
