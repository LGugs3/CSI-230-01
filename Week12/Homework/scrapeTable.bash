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
 echo "$name" >> $outputFile

 #go row by row
 while [[ ! -z "$line" ]]
 do
  line="$(cat "$fileName" | pup "table#$name tr:nth-of-type($counter) td:first-of-type text{}")"
  echo "$line" >> $outputFile
  counter=$(($counter + 1))
 done

 echo "$outputFile"
}

function getDates()
{
 #bootstrap
 local line="start"
 local counter=2
 local name="temp"
 local outputFile="dateTable.txt"

 #create file based on column name
 :> "$outputFile"
 echo "date" >> "$outputFile"

 #row by row
 while [[ ! -z "$line" ]]
 do
  line="$(cat "$fileName" | pup "table#$name tr:nth-of-type($counter) td:last-of-type text{}")"
  echo "$line" >> $outputFile
  counter=$(($counter + 1))
 done

 echo "$outputFile"
}

function combineTables()
{
 local outputFile="combinedTable.txt"
 local fileLength=$(wc -l $1 | cut -d' ' -f1) #assumes all files are the same length
 local line=""
 
 :> $outputFile

 for i in $(seq 1 $fileLength)
 do
  line=""
  for file in "$@"
  do
    line+="$(head -n $i $file | tail -1) "
  done
  echo "$line" >> $outputFile
 done

 echo "$outputFile"
}

colOne=$(scrapeColumn "press")
colTwo=$(scrapeColumn "temp")
colThree=$(getDates)

echo "$colOne, $colTwo, $colThree"

fileName=$(combineTables $colOne $colTwo $colThree)

cat "$fileName"
