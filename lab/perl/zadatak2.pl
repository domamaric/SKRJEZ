#!perl

print "Unesite nekoliko brojeva:\n";

chomp(@numbers = <STDIN>);

$sum += $_ for @numbers;  # Defaultno se inicijalizira na 0

$mean = $sum / @numbers;  # Dijelimo s duljinom liste

print "Aritmeticka sredina ucitanih brojeva: $mean \n";
