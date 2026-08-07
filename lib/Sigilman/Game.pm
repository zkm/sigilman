package Sigilman::Game;
use strict;
use warnings;

use constant DEFAULT_MAX_ATTEMPTS => 6;

sub new {
    my ($class, %args) = @_;
    my $word = lc($args{word} // die "Sigilman::Game->new requires a 'word' argument\n");

    return bless {
        word          => $word,
        max_attempts  => $args{max_attempts} // DEFAULT_MAX_ATTEMPTS,
        guessed       => {},   # letter => 1
        wrong_count   => 0,
    }, $class;
}

# Returns one of: 'correct', 'incorrect', 'already_guessed', 'invalid'
sub guess {
    my ($self, $letter) = @_;
    $letter = lc($letter // '');

    return 'invalid' unless $letter =~ /^[a-z]$/;
    return 'already_guessed' if $self->{guessed}{$letter};

    $self->{guessed}{$letter} = 1;

    if (index($self->{word}, $letter) >= 0) {
        return 'correct';
    }

    $self->{wrong_count}++;
    return 'incorrect';
}

sub guessed_letters {
    my $self = shift;
    return sort keys %{ $self->{guessed} };
}

sub wrong_letters {
    my $self = shift;
    return sort grep { index($self->{word}, $_) < 0 } keys %{ $self->{guessed} };
}

sub wrong_count {
    my $self = shift;
    return $self->{wrong_count};
}

sub remaining_attempts {
    my $self = shift;
    return $self->{max_attempts} - $self->{wrong_count};
}

sub max_attempts {
    my $self = shift;
    return $self->{max_attempts};
}

sub word {
    my $self = shift;
    return $self->{word};
}

# Word with unguessed letters replaced by underscores, e.g. "_ a _ e"
sub masked_word {
    my $self = shift;
    return join ' ', map { $self->{guessed}{$_} ? $_ : '_' } split //, $self->{word};
}

sub is_won {
    my $self = shift;
    return !grep { !$self->{guessed}{$_} } split //, $self->{word};
}

sub is_lost {
    my $self = shift;
    return $self->{wrong_count} >= $self->{max_attempts};
}

sub is_over {
    my $self = shift;
    return $self->is_won || $self->is_lost;
}

1;
