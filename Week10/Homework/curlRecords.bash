#!/bin/bash

file="/var/log/apache2/access.log"

function getPagesAccessed()
{
 pages=$(cat "$file" | cut -d' ' -f1,12)
}

function groupPages()
{
 groups=$(echo "$pages" | grep "curl/7.81.0" | sort | uniq -c)
}

getPagesAccessed
groupPages

#echo "$(cat "$file" | grep "10")"
echo "$groups"
