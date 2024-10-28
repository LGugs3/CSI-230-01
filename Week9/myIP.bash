#!/bin/bash

ip addr | grep -oE "[[:digit:]]{1,3}\.[[:digit:]]{1,3}\.[[:digit:]]{1,3}\.[[:digit:]]{1,3}/" | tail -1 | awk '{ print substr($0, 1, length($0)-1 ) }'
