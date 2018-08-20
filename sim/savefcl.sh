#!/usr/bin/env bash

##################################################
# SAVEFCL: Save recently scraped FOCAL listings  #
##################################################
F69DIR="$HOME/sim/focal69"			 #
F15DIR="$HOME/sim/focal15"			 #
##################################################

# Check if enough arguments are supplied and the console log exists #
if [ "$#" -ne 1 ]; then
	echo "usage: savefcl [filename]"
	exit
fi

# Check that recent FOCAL listing actually exists #
if [ ! -f "$F69DIR/lastlisting.fcl69" ]; then
	echo "No recent FOCAL-69 listing found!"
	echo "FOCAL-69 sessions executed with the command 'focal69'"
	echo "will always automatically save the last full program"
	echo "listing to the 'sim/focal69' folder in your home directory."
	exit
fi

# Save the last listing with the user's specified filename #
cp "$F69DIR/lastlisting.fcl69" "$F69DIR/$1"

# Check if the copy was successful #
if [ -f "$F69DIR/$1" ]; then
	echo "Successfully saved last FOCAL listing as '$1'"
	exit
else
	echo "Could not save FOCAL listing!"
	exit
fi
