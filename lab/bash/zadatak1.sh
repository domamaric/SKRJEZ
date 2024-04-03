#!/bin/bash

proba='Ovo je proba'

echo $proba

lista_datoteka=*
# for datoteka in "${lista_datoteka[@]}"; do
#     echo "$datoteka"
# done
echo $lista_datoteka

proba3=''
for i in {1..3}; do
    proba3+="$proba. "
done
echo $proba3

a=4
b=3
c=7
d=$(( ($a + 4) * $b % $c ))

echo $a $b $c $d

broj_rijeci=$(wc -w *.txt | awk '{ sum += $1 } END { print sum }')
echo $broj_rijeci

ls ~