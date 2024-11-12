#!/bin/bash

url="10.0.17.6/Assignment.html"
fileName="table.html"

:> table.html

#populate html file
curl -so $fileName $url

function scrapeColumn()
{
 #bootstrap
 local line="start"
 local counter=2
 local name="$1"

 #create file based on column name
 outputFile="${name}Table.txt"
 :> "$outputFile"

 #go row by row
 while [[ ! -z "$line" ]]
 do
  line="$(cat "$fileName" | pup "table#$name tr:nth-of-type($counter) td:first-of-type text{}")"
  echo "$line" >> $outputFile
  counter=$(($counter + 1))
done
}

function getDates()
{
 #bootstrap
 local line="start"
 local counter=2
 local name="temp"

 #create file based on column name
 :> "dateTable.txt"

 #row by row
 while [[ ! -z "$line" ]]
 do
  line="$(cat "$fileName" | pup "table#$name tr:nth-of-type($counter) td:nth-of-type(2) text{}}")"
  echo "$line" >> "dateTable.txt"
  counter=$(($counter + 1))
done
}

scrapeColumn "temp"
scrapeColumn "press"
getDates
