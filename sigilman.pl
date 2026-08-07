#!/usr/bin/env perl
use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/lib";

use Sigilman::Words;
use Sigilman::Game;
use Sigilman::Display;

my $WORDLIST = "$FindBin::Bin/words/default.txt";

sub main {
    my $words = Sigilman::Words->new(file => $WORDLIST);
    my $game  = Sigilman::Game->new(word => $words->random_word);

    print "Welcome to Sigilman! Guess the word one letter at a time.\n";
    print "You have " . $game->max_attempts . " wrong guesses before the game is over.\n\n";

    until ($game->is_over) {
        print Sigilman::Display->board($game);
        print "\nGuess a letter (or 'quit'): ";

        my $input = <STDIN>;
        unless (defined $input) {
            print "\nGoodbye!\n";
            exit 0;
        }
        chomp $input;
        $input = lc $input;

        if ($input eq 'quit' || $input eq 'exit') {
            print "Thanks for playing. The word was: " . $game->word . "\n";
            exit 0;
        }

        my $result = $game->guess($input);

        if ($result eq 'invalid') {
            print "\nPlease enter a single letter (a-z).\n";
        } elsif ($result eq 'already_guessed') {
            print "\nYou already guessed '$input'.\n";
        } elsif ($result eq 'correct') {
            print "\nNice, '$input' is in the word!\n";
        } elsif ($result eq 'incorrect') {
            print "\nSorry, no '$input' in the word.\n";
        }
        print "\n";
    }

    print Sigilman::Display->board($game);

    if ($game->is_won) {
        print "\nYou win! The word was: " . $game->word . "\n";
    } else {
        print "\nYou lose! The word was: " . $game->word . "\n";
    }
}

main();
