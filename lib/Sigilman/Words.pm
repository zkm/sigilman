package Sigilman::Words;
use strict;
use warnings;

sub new {
    my ($class, %args) = @_;
    my $file = $args{file} or die "Sigilman::Words->new requires a 'file' argument\n";

    open my $fh, '<', $file or die "Can't open word list '$file': $!\n";
    my @words;
    while (my $line = <$fh>) {
        chomp $line;
        $line =~ s/#.*$//;      # strip comments
        $line =~ s/^\s+|\s+$//g; # trim whitespace
        next unless length $line;
        push @words, lc $line;
    }
    close $fh;

    die "Word list '$file' contains no usable words\n" unless @words;

    return bless { words => \@words }, $class;
}

sub count {
    my $self = shift;
    return scalar @{ $self->{words} };
}

sub random_word {
    my $self = shift;
    return $self->{words}[ int rand scalar @{ $self->{words} } ];
}

1;
