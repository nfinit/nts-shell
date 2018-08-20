#!/usr/bin/env bash

#######################################
# SIMDOC: SIMple DOCumentation viewer #
#######################################
DOCDIR="/usr/share/simh/docs"	      #
#######################################

if [ -f "$DOCDIR/$1" ]; then
	less $DOCDIR/$1
else
	if [ "$#" -ne 1 ]; then
		echo "usage: simdoc <file>"
		exit
	fi
	FCHAR=$(echo "${1}" | cut -c1)
	NFILE=$(find $DOCDIR/ -name "$FCHAR*" | wc -l)
	echo "No documents explicitly matching your keyword could be found."
	echo -n "Possibly related documents: "
	if [ $NFILE -eq 0 ]; then
		echo "none"
	else 
		echo ""
		find $DOCDIR/ -name "$FCHAR*" | sed s/^.*\\/\//
	fi
fi
