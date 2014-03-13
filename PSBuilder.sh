#!/bin/bash

rc=$1
#echo
echo -n -e ┌\(
# Print Last Command Sucessful
if [ $rc -eq 0 ]; then
        echo -en \\\e[01\;32m✓
else
        echo -en \\\e[01\;31m✗
fi
echo -e \ $rc\\\e[0m\)─\(\\\e[34m$(date)\\\e[0m\)
##################
# Seperation Bar #
##################
hostnamecolor=$(hostname | od | tr ' ' '\n' | awk '{total = total + $1}END{print 30 + (total % 6)}')
echo -e "├\e[${hostnamecolor}m████████████████████████████████████████████████████████\e[0m"
############
# Git Info #
############
git branch &> /dev/null
if [ $? -eq 0 ]; then
	echo -ne ├\(\\\e[36mGIT\:
	echo -n `git branch | cut -b 3-`
	echo -ne \\\e[0m\)─
	
	echo `git status` | grep "nothing to commit" > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo -ne \(\\\e[32mNothing to commit\\\e[0m\)
	else
		echo -n "(`git status -s | grep "?? " | wc -l` Untracked, `git status -s | grep "A  " | wc -l` Added, `git status -s | grep " M " | wc -l` Modified)"
	fi
	echo
fi
#######################
# Current Enviornment #
#######################
echo -ne ├\(
if [[ $EUID -ne 0 ]]; then
        echo -en \\\e[35m$USER
else
        echo -en \\\e[31mROOT
fi
echo -ne \\\e[39m@\\\e[32m$HOSTNAME\\\e[0m\)
echo -ne ─\(\\\e[36m$(ls -1 | wc -l | sed 's: ::g') files\@$(ls -lah | grep -m 1 total | sed 's/total //')\\\e[0m\)
echo -e ─\\\e[36m$PWD\\\e[0m
############
#Final Line#
############
echo └\>
