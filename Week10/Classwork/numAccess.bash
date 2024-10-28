#!/bin/bash

file="/var/log/apache2/access.log"

function getPagesAccessed()
{
 pages=$(cat "$file" | cut -d' ' -f7)
}

function groupPages()
{
 groups=$(echo "$pages" | grep -v "408" | sort | uniq -c)
}

getPagesAccessed
groupPages

echo "$groups"
