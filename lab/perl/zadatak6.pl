#!perl

use open ':locale';
use locale;
use utf8;

# Ne zaboravi podesiti variablu ljuske: export LC_ALL=hr_HR.UTF-8

if ( @ARGV == 1 ) {
    # Only prefix length is given, read from STDIN
    my @lines;

    while ( <STDIN> ) {
        push @lines, $_;
    }

    &count_prefix_words($ARGV[0], @lines)
} else {
    my $prefix_len = pop @ARGV; # Last argument is prefix len

    foreach ( @ARGV ) {
        my @lines;
        open my $fp, '<', $_ or die "Cannot open file $_\n";

        while (my $line = <$fp>) {
            push @lines, $line;
        }

        close $fp;

        &count_prefix_words($prefix_len, @lines);
    }
}

sub count_prefix_words {
    my ($prefix_len, @lines) = @_;
    my %prefix_counts;

    foreach ( @lines ) {
        chomp;
        # Remove punctuation and split words of len >= $prefix_len
        my @words = grep { length($_) >= $prefix_len } split /[^\w']+/, lc $_;

        foreach my $word (@words) {
            my $prefix = substr $word, 0, $prefix_len;
            $prefix_counts{$prefix}++;
        }
    }

    foreach my $prefix (sort keys %prefix_counts) {
        print "$prefix : $prefix_counts{$prefix}\n";
    }
}
