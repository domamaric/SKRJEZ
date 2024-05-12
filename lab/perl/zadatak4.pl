#!perl

my @lines;

if ( @ARGV == 0 ) { # Read from STDIN
    while ( <STDIN> ) {
        chomp $_;
        push @lines, $_;
    }
} else { # Read from file
    open $fp, '<', @ARGV[0] or die "Cannot open file @ARGV[0]\n";

    while (my $line = <$fp>) {
        chomp $line;
        push @lines, $line;
    }

    close $fp;
}

for my $line ( @lines ) {
    my ($jmbag, $surname, $name, $term, $submitted) = split /;/, $line;
    my $diff = &timestamp_diff($term, $submitted);

    my @parts = split / /, $term;
    if ( $diff > 3_600 ) {
        print "$jmbag $surname $name - PROBLEM: @parts[0] @parts[1] --> $submitted\n";
    }
}

sub timestamp_diff {
    my @start_parts = split / /, $_[0];
    my @end_parts = split / /, $_[1];

    my $start_timestamp = @start_parts[0];
    my $end_timestamp = @end_parts[0];

    my ($start_year, $start_month, $start_day) = split /\-/, $start_timestamp;
    my ($end_year, $end_month, $end_day) = split /\-/, $end_timestamp;

    my $diff = 0;
    $diff += ($end_year - $start_year) + ($end_month - $start_month) + ($end_day - $start_day);
    $diff *= 86_400;  # Convert to seconds

    my ($start_hour, $start_minute, $start_second) = split /:/, @start_parts[1];
    my ($end_hour, $end_minute, $end_second) = split /:/, @end_parts[1];

    $diff += ($end_hour - $start_hour) * 3_600 + ($end_minute - $start_minute) * 60 + ($end_second - $start_second);

    return $diff;
}
