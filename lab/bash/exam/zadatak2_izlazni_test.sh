#!/bin/bash

if [ "$#" -ne 1 ]; then
	echo -e "Neispravan broj argumenata. Upute za koristenje:\n"
	echo "./zadatak2.sh [putanja_do_log_datoteke]"
	exit 1
fi

if [ ! -r $1 ]; then
	echo "Datoteka nije citljiva!"
	exit 1 
fi

cat $1 | cut -f 2 -d ':' | sort | uniq -c -d | sed -r 's/\s+([0-9]*)\s+(.*)/\2 \1/'
