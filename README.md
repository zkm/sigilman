# Sigilman

[![CI](https://github.com/zkm/sigilman/actions/workflows/ci.yml/badge.svg)](https://github.com/zkm/sigilman/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue)](LICENSE)

![Perl 5.10+](https://img.shields.io/badge/Perl-5.10%2B-39457E?logo=perl&logoColor=white)
![Core modules only](https://img.shields.io/badge/dependencies-core%20modules%20only-brightgreen)
![Test::More](https://img.shields.io/badge/tests-Test%3A%3AMore-39457E)
![Terminal](https://img.shields.io/badge/runs%20in-terminal-4D4D4D)

A classic hangman game, played in your terminal, written in Perl.

## Requirements

- Perl 5.10 or newer (core modules only, no CPAN dependencies required to play)

## Running

```sh
./sigilman.pl
```

Guess one letter at a time. You have 6 wrong guesses before the gallows is
complete and the game is over.

## Project layout

```
sigilman.pl              # entry point / game loop
lib/Sigilman/
  Game.pm                 # game state: guesses, win/lose logic
  Words.pm                 # word list loading and random selection
  Display.pm               # ASCII gallows art and board rendering
words/default.txt          # default word list, one word per line
t/                          # tests (run with `prove -l t`)
```

## Tests

```sh
prove -l t
```

## Custom word lists

Word list files are plain text, one word per line. Lines starting with `#`
are treated as comments and blank lines are ignored. Point `sigilman.pl` at
a different file by editing `$WORDLIST` or passing your own path to
`Sigilman::Words->new(file => $path)` if you're scripting against the
library directly.
