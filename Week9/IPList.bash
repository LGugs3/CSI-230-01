#!/bin/bash
#Own IP is 10.0.17.21

#Checks if prefix argument is provided
[ $# -lt 1 ] && echo "Usage: $0 <Prefix>" && exit 1

#Checks if the prefix is at least 5 characters long
[ ${#1} -lt 5 ] && \
printf "Prefix length too short\nPrefix Example: 10.0.17\n" && exit 1

prefix=$1

for i in {1..254}
do
	ping -c 1 $prefix.$i | grep -q " 0% packet loss" &&  echo "$prefix.$i"
done
