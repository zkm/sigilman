package Sigilman::Display;
use strict;
use warnings;

my @GALLOWS_STAGES = (
    # 0 wrong guesses
    "
  +---+
  |   |
      |
      |
      |
      |
=========",
    # 1
    "
  +---+
  |   |
  O   |
      |
      |
      |
=========",
    # 2
    "
  +---+
  |   |
  O   |
  |   |
      |
      |
=========",
    # 3
    "
  +---+
  |   |
  O   |
 /|   |
      |
      |
=========",
    # 4
    "
  +---+
  |   |
  O   |
 /|\\  |
      |
      |
=========",
    # 5
    "
  +---+
  |   |
  O   |
 /|\\  |
 /    |
      |
=========",
    # 6
    "
  +---+
  |   |
  O   |
 /|\\  |
 / \\  |
      |
=========",
);

sub gallows {
    my ($class, $wrong_count) = @_;
    my $max = $#GALLOWS_STAGES;
    my $stage = $wrong_count > $max ? $max : $wrong_count;
    return $GALLOWS_STAGES[$stage];
}

sub board {
    my ($class, $game) = @_;
    my @lines;

    push @lines, $class->gallows($game->wrong_count);
    push @lines, '';
    push @lines, 'Word:    ' . $game->masked_word;
    push @lines, 'Wrong:   ' . (join(' ', $game->wrong_letters) || '(none)');
    push @lines, 'Guesses left: ' . $game->remaining_attempts . ' / ' . $game->max_attempts;

    return join("\n", @lines) . "\n";
}

1;
