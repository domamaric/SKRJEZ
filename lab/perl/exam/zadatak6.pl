#!perl

die "Upute za koristenje: perl zadatak6.pl <ime_datoteke>\n" unless @ARGV == 1;

my $filename = @ARGV[0];

open $fp, '<', $filename or die "Could not open file $filename\n";

my @lines;

while ( my $line = <$fp> ) {
	chomp $line;
	push @lines, $line;
}

close $fp;

my %errors;
my %warnings;
my %informations;

for my $i ( 1 .. $#lines ) {
	my $row = @lines[$i];
	my ($level, $date, $source, $event, $task, $category) = split "\t", $row;

	if ( $level == 'Error' ) {
		$errors{$source}++;
	} elsif ( $level == 'Warning' ) {
		$warnings{$source}++;
	} elsif ( $level == 'Information' ) {
		$informations{$source}++;
	}
}

print "\n==================================================";
print "\n Level: Error\n Source: num. records\n";
print "--------------------------------------------------\n";

foreach my $key (reverse sort { $errors{$a} <=> $errors{$b} } keys %errors ) {
	print "$key : $errors{$key}\n";
}

print "\n==================================================";
print "\n Level: Information\n Source: num. records\n";
print "--------------------------------------------------\n";

foreach my $key (reverse sort { $informations{$a} <=> $informations{$b} } keys %informations ) {
	print "$key : $informations{$key}\n";
}

print "\n==================================================";
print "\n Level: Warning\n Source: num. records\n";
print "--------------------------------------------------\n";

foreach my $key (reverse sort { $warnings{$a} <=> $warnings{$b} } keys %warnings ) {
	print "$key : $warnings{$key}\n";
}
