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
echo -e \ $rc\\\033[0m\)─\(\\\033[34m$(date)\\\033[0m\)
##################
# Seperation Bar #
##################
hostnamecolor=$(hostname | od | tr ' ' '\n' | awk '{total = total + $1}END{print 30 + (total % 6)}')
echo -e "├\033[${hostnamecolor}m████████████████████████████████████████████████████████\033[0m"
############
# Git Info #
############
git branch &> /dev/null
if [ $? -eq 0 ]; then
	echo -ne ├\(\\\033[36mGIT\:
	echo -n `git branch | cut -b 3-`
	echo -ne \\\033[0m\)─
	
	echo `git status` | grep "nothing to commit" > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo -ne \(\\\033[32mNothing to commit\\\033[0m\)
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
        echo -en \\\033[35m$USER
else
        echo -en \\\033[31mROOT
fi
echo -ne \\\033[39m@\\\033[32m$HOSTNAME\\\033[0m\)
echo -ne ─\(\\\033[36m$(ls -1 | wc -l | sed 's: ::g') files\@$(ls -lah | grep -m 1 total | sed 's/total //')\\\033[0m\)
echo -e ─\\\033[36m$PWD\\\033[0m
############
#Final Line#
############
echo └\>
