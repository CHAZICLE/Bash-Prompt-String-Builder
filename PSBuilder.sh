#!/bin/bash

rc=$1
#echo
echo -n -e ┌\(
# Print Last Command Sucessful
if [ $rc -eq 0 ]; then
        echo -en \\\033[01\;32m✓
else
        echo -en \\\033[01\;31m✗
fi
echo -ne \ $rc\\\e[0m\)
#Time/Date
echo -ne ─\(\\\e[34m$(date)\\\e[0m\)
echo
#############
#SECOND LINE#
#############
#echo -ne ├▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
hostnamecolor=$(hostname | od | tr ' ' '\n' | awk '{total = total + $1}END{print 30 + (total % 6)}')
echo -ne "├\e[${hostnamecolor}m████████████████████████████████████████████████████████\e[0m"
echo
##############
#Current Info#
##############
echo -ne ├\(
if [[ $EUID -ne 0 ]]; then
        echo -en \\\e[35m$USER
else
        echo -en \\\e[31mROOT
fi
echo -ne \\\e[39m@\\\e[32m$HOSTNAME\\\e[0m\)
echo -ne ─\(\\\e[36m$(ls -1 | wc -l | sed 's: ::g') files\\\e[0m\)─\(\\\e[36m$(ls -lah | grep -m 1 total | sed 's/total //')\\\e[0m\)
echo -e ─\\\e[36m$PWD\\\e[0m
############
#Final Line#
############
echo └\>
