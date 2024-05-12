#!perl

if ( @ARGV == 0 ) {
    # Citaj sa standardonga ulaza
    @data;
    while ( <STDIN> ) {
        chomp $_;
        push @data, $_;
    }

    for $line ( @data ) {
        ($jmbag, $surname, $name, $term, $submitted) = split /;/, $line;
        $diff = &timestamp_diff($term, $submitted);

        @parts = split / /, $term;
        if ( $diff > 3_600 ) {
            print "$jmbag $surname $name - PROBLEM: @parts[0] @parts[1] -> $submitted\n";
        }
    }
} else {
    # Citaj iz datoteke
    open $fp, '<', @ARGV[0] or die "Cannot open file @ARGV[0]\n";

    for $line ( <$fp> ) {
        chomp $line;
        ($jmbag, $surname, $name, $term, $submitted) = split /;/, $line;
        $diff = &timestamp_diff($term, $submitted);

        @parts = split / /, $term;
        if ( $diff > 3_600 ) {
            print "$jmbag $surname $name - PROBLEM: @parts[0] @parts[1] -> $submitted\n";
        }
    }

    close $fp;
}

sub timestamp_diff {
    @start_parts = split / /, $_[0];
    @end_parts = split / /, $_[1];

    $start_timestamp = @start_parts[0];
    $end_timestamp = @end_parts[0];

    ($start_year, $start_month, $start_day) = split /\-/, $start_timestamp;
    ($end_year, $end_month, $end_day) = split /\-/, $end_timestamp;

    my $diff = 0;
    $diff += ($end_year - $start_year) + ($end_month - $start_month) + ($end_day - $start_day);
    $diff *= 86_400;  # Pretvaranje u sekunde

    ($start_hour, $start_minute, $start_second) = split /:/, @start_parts[1];
    ($end_hour, $end_minute, $end_second) = split /:/, @end_parts[1];

    $diff += ($end_hour - $start_hour) * 3_600 + ($end_minute - $start_minute) * 60 + ($end_second - $start_second);

    return $diff;
}
