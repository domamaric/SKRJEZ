#!/bin/bash

if [ ! -d "$1" ] || [ ! -d "$2" ]; then  # [ -d ] skraceno za test -d
    echo "Neki od direktorija ne postoji. Upute za koristenje:"
    echo "./zadatak6.sh [PRVI_DIREKTORIJ] [DRUGI_DIREKTORIJ]"
    exit 1
fi

for file1 in "$1"/*; do
    file2=$2/${file1##*/}  # Ekvivalent basename

    if [ ! -f $file2 ] || [ $file1 -nt $file2 ]; then # Datoteka ne postoji i novija je
        echo "$file1 --> $(dirname $file2)"
    fi
done

echo

for file2 in "$2"/*; do
    file1=$1/${file2##*/}  # Ekvivalent basename

    if [ ! -f $file1 ] || [ $file2 -nt $file1 ]; then # Datoteka ne postoji i novija je
        echo "$file2 --> $(dirname $file1)"
    fi
done
