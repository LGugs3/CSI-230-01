#!/bin/bash

IOCWebpage="10.0.17.6/IOC.html"
logFile="$1"
IOCFile="$2"

function scrapeIOCPage()
{
 #empty files we are about to use
 :> rawHtml.txt
 :> IOC.txt

 curl -s "$IOCWebpage" > rawHtml.txt
 cat rawHtml.txt | pup 'table tr td:first-of-type text{}' > IOC.txt

 rm rawHtml.txt
}

function listIOC()
{
 #clearing file we are about to use
 :> report.txt
 :> shortLog.log

 cat "$logFile" | cut -d' ' -f1,4,7 > shortLog.log

 while read -r line
 do
  grep "$line" "shortLog.log" >> report.txt
done < "$IOCFile"
}

listIOC

