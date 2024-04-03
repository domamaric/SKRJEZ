#!/bin/bash

if [ ! -d "$1"  ]; then  # [ -d ] skraceno za test -d
    echo "Direktorij ne postoji. Upute za koristenje:"
    echo "./zadatak3.sh [PUTANJA_DO_DIREKTORIJA]"
    exit 1
fi

for logfile in "$1"/??-02-????.txt; do
    filename="$(basename $logfile)"
    date="${filename%.*}"

    echo "datum: $date"
    echo '--------------------------------------------------'
    cat $logfile | cut -d'"' -f 2 | sort | uniq -c | sort -rn | sed -r 's/\s+([0-9]*)(\s+)(.*)/  \1 : \3/' 
done