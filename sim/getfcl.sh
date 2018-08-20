#!/usr/bin/env bash

###########################################
# GETFCL: Crude FOCAL-69 listing scraper  #
###########################################

# Check if enough arguments are supplied and the console log exists #
if [[ "$#" -ne 2 || ! -f "$1" ]]; then
	echo "usage: getfcl <console log> <destination file>"
	exit
fi

# Look for a starting number #
CURRNUM=$(grep -n "C-FOCAL,1969" "$1" | tail -1 | cut -f1 -d:)
if [ -z "$CURRNUM" ]; then
	echo "No FOCAL-69 listing header present in logfile!"
	echo "Listing file will not be saved or updated."
	exit
else
	echo "Found FOCAL-69 listing at line $CURRNUM!"
	echo "Saving listing to file \"$2\"..."
fi

rm -f $2
touch $2
CURRLINE=$(sed "${CURRNUM}q;d" $1)
while [[ ! "$CURRLINE" = "*"* ]]; do 
	echo $CURRLINE >> $2
	((CURRNUM++))	
	CURRLINE=$(sed "${CURRNUM}q;d" $1)
done 
