#!perl

my @data;
my %students;

open my $fp, '<', $ARGV[0] or die "Cannot open file $ARGV[0]\n";

while (my $line = <$fp>) {
    chomp $line;
    next if $line =~ /^\s*$/ || $line =~ /^\s*#/; # Skip empty lines or lines starting with #
    push @data, $line;
}

close $fp;

my @shares = split /;/, $data[0]; # data[0] contains shares of components

for my $i (1 .. @data - 1) {
    my @fields = split /;/, $data[$i];
    my $key = "$fields[1], $fields[2] ($fields[0])";
    my $sum = 0;

    for my $j (0 .. $#fields - 3) {
        $sum += $fields[3 + $j] * $shares[$j];
    }

    $students{$key} = $sum;
}

print "Lista po rangu:\n-------------------\n";

my $index = 1;
foreach my $id (reverse sort { $students{$a} <=> $students{$b} } keys %students) {
    printf "   %s. %s\t: %.2f\n", $index++, $id, $students{$id};
}
