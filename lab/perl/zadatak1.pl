#!perl

print 'Unesite niz znakova > ';

$input = <STDIN>;  # Ne treba chomp jer se trazi ispis u novome redu

print 'Unesite broj ponavljanja n > ';

chomp($n = <STDIN>);

$array = $input x $n;

print $array
