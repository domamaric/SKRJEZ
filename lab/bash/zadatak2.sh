#!/bin/bash

grep -i -E 'banana|jabuka|jagoda|dinja|lubenica' namirnice.txt

grep -i -v -E 'banana|jabuka|jagoda|dinja|lubenica' namirnice.txt

grep -r -E '\b[A-Z]{3}[0-9]{6}\b' ~/projekti/

find . -type f -mtime +7 -mtime -14 -ls

for i in {1..15}; do echo $i; done

kraj=4
for i in $(seq $kraj); do echo $i; done