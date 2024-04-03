#!/bin/bash

if [ "$#" -ne 2 ]; then  # [ -d ] skraceno za test -d
    echo "Neispravan broj argumenata. Upute za koristenje:"
    echo "./zadatak5.sh [PUTANJA_DO_DIREKTORIJA] [EKSTENZIJA_DATOTEKE]"
    exit 1
fi

echo "$1 $2"

count=$(find "$1" -type f -name "$2" -print0 | xargs -0 awk 'END { total += NR } END { print total }')

echo "Ukupan broj redaka u datotekama s imenima ciji je oblik ($2): $count"