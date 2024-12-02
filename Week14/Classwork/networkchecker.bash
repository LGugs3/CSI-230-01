#!/bin/bash

myIPfile="/home/champuser/CSI-230-01/Week9/myIP.bash"
myIP=$(bash $myIPfile)


# Todo-1: Create a helpmenu function that prints help for the script
function usage()
{
 echo "  Help Menu"
 echo "-------------"
 echo "-n [ FILTER ]: Uses nmap"
 echo "  external: external nmap scan"
 echo "  internal: internal nmap scan"

 echo "-s [ FILTER ]: Uses ss"
 echo "  external: external ss scan"
 echo "  internal: internal ss scan"
 echo ""
 echo "Usage: $0 [-n \"<external|internal>\"] [-s \"<external|internal>\"]" 1>&2
 echo "-------------"

 exit 1
}

# Return ports that are serving to the network
function ExternalNmap(){
  rex=$(nmap "${myIP}" | awk -F"[/[:space:]]+" '/open/ {print $1,$4}' )
}

# Return ports that are serving to localhost
function InternalNmap(){
  rin=$(nmap localhost | awk -F"[/[:space:]]+" '/open/ {print $1,$4}' )
}


# Only IPv4 ports listening from network
function ExternalListeningPorts(){
# Todo-2: Complete the ExternalListeningPorts that will print the port and application
# that is listening on that port from network (using ss utility)
  half=$(ss -ltpn4 | tail -n +2 | awk -F"[[:space:](),)]+" '!/127.0.0./ {print $4,$7}' | tr -d "\"")
  expo=$(echo "$half" | awk -F':' '{print $NF}')

}


# Only IPv4 ports listening from localhost
function InternalListeningPorts(){
ilpo=$(ss -ltpn | awk  -F"[[:space:]:(),]+" '/127.0.0./ {print $5,$9}' | tr -d "\"")
}



# Todo-3: If the program is not taking exactly 2 arguments, print helpmenu
[[ $# -ne 2 ]] && echo "only 2 arguments are eccepted, not $#" && usage
# Todo-4: Use getopts to accept options -n and -s (both will have an argument)
# If the argument is not internal or external, call helpmenu
# If an option other then -n or -s is given, call helpmenu
# If the options and arguments are given correctly, call corresponding functions
# For instance: -n internal => will call NMAP on localhost
#               -s external => will call ss on network (non-local)
while getopts "n:s:" option
do
  case $option in
  n)
    [ ${OPTARG} == "internal" -o ${OPTARG} == "external" ] || usage

    [ "${OPTARG}" == "internal" ] && InternalNmap && echo "$rin"
    [ "${OPTARG}" == "external" ] && ExternalNmap && echo "$rex"
  ;;
  s)
    [ ${OPTARG} == "internal" -o ${OPTARG} == "external" ] || usage

    [ ${OPTARG} == "internal" ] && InternalListeningPorts && echo "$ilpo"
    [ ${OPTARG} == "external" ] && ExternalListeningPorts && echo "$expo"
  ;;
  *)
    echo "$0: illegal option -- ${OPTARG}"
    usage
  ;;
  esac
done
