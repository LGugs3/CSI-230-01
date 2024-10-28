#!/bin/bash

numcurl=20
ip="10.0.17.21"
[ $# -eq 1 ] && $numCurl=$0

for i in $(seq 1 $numcurl)
do
  curl $ip
done
