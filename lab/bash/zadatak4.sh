#!/bin/bash

if [ ! -d "$1"  ]; then  # [ -d ] skraceno za test -d
    echo "Direktorij ne postoji. Upute za koristenje:"
    echo "./zadatak4.sh [PUTANJA_DO_DIREKTORIJA]"
    exit 1
fi

current_month=''

for image in $(ls "$1"/*.jpg); do  # ls defaultno sortira uzlazno
    filename="$(basename $image)"
    date="${filename%.*}";month="${date:4:2}";year="${date:0:4}"
    
    if [ "$current_month" != "$month" ]; then
        if [ "$current_month" != '' ]; then
            echo "--- Ukupno: $count slika -----"
        fi
        count=0
        current_month=$month
        echo -e "${month}-${year}:\n----------"
    fi

    count=$((count + 1))
    echo "  $count. $filename"
done

echo -e "--- Ukupno: $count slika -----"
