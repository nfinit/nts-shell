if [[ -f $1  && ! "$1" = "" ]]; then
	pdftotext -layout -eol unix -nopgbrk $1 - | sed 's/\.\.\.*/\.\.\./g' | fold -w $(tput cols) -s | less
else
	echo "usage: showpdf <file>"
fi
