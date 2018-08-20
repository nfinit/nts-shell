#!/usr/bin/env bash

#############################################
# NTS CALSTAT: Simple CalCurse status alert #
#############################################

# Check if calcurse has been used first #
if [ -d "$HOME/.calcurse" ]; then
	# Only the default calendar will be printed #
	tput setaf 006
	echo -n "Today's appointments for "
	calcurse -a
	echo -ne "\n"
	tput sgr0
fi
