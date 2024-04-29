#!perl

if ( @ARGV == 0 ) {
    # Citaj podatke sa standardnog ulaza
    print "\n sat : broj pristupa\n-------------------------------\n";

    @hour_counts = (0) x 24;
    for $line ( <STDIN> ) {
        @parts = split(/:/, $line);
        $hour = $parts[1];
        ++$hour_counts[$hour];
    }

    for $i ( 0..23 ) {
        printf "  %02d : %d\n", $i, $hour_counts[$i];
    }
} else {
    # Citaj podatke iz datoteka
    for ( @ARGV ) {
        $_ =~ /(\d{4})-(\d{2})-(\d{2})/;
        print "\n Datum: $1-$2-$3\n sat : broj pristupa\n";
        print "-------------------------------\n";
        no_of_accesses( $_ );
    }
}

sub no_of_accesses() {
    if ( ! open CONFIG, $_) {
        die 'Cannot open file';
    }

    @hour_counts = (0) x 24;

    for $line ( <CONFIG> ) {
        @parts = split(/:/, $line);
        $hour = $parts[1];
        ++$hour_counts[$hour];
    }

    for $i ( 0..23 ) {  # Koristim $i da ne bude zabune sa vanjskim $_
        printf "  %02d : %d\n", $i, $hour_counts[$i];
    }

    close ( CONFIG );
}
