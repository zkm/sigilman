# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Sigilman — a terminal hangman game written in Perl, using only core Perl
modules (no CPAN dependencies required to play or test).

## Commands

Run the game:
```sh
./sigilman.pl
```

Run all tests:
```sh
prove -l t
```

Run a single test file:
```sh
prove -l t/game.t
```

## Architecture

- `sigilman.pl` is the entry point and owns the game loop: it picks a word
  via `Sigilman::Words`, creates a `Sigilman::Game`, and repeatedly renders
  the board via `Sigilman::Display` and reads a letter from STDIN until the
  game is over.
- `Sigilman::Game` is the only place holding game state (the target word,
  guessed letters, wrong-guess count). It has no knowledge of I/O or
  rendering — `guess($letter)` returns a status string
  (`correct`/`incorrect`/`already_guessed`/`invalid`) rather than printing
  anything, so it can be tested in isolation (see `t/game.t`).
- `Sigilman::Words` loads a word list file at construction time
  (`new(file => $path)`) and exposes `random_word`. Word list format: one
  word per line, `#` starts a comment, blank lines ignored. The default list
  lives at `words/default.txt`; tests use a separate fixture at
  `t/fixtures/words.txt` so editing the real word list can't break tests.
- `Sigilman::Display` is stateless rendering: it takes a `Sigilman::Game`
  and produces the ASCII gallows art (7 stages, indexed by wrong-guess
  count) plus the masked word and guess status as a string. It never reads
  input or holds state itself.
- Module resolution: `sigilman.pl` uses `FindBin` to add `lib/` to `@INC`
  relative to the script's location, so the game can be run from any
  working directory.

## Perl gotcha to watch for

`grep { BLOCK } LIST` is a list operator with low precedence — in something
like `ok(!grep { ... } keys %seen, 'message')`, the string argument gets
swallowed into grep's LIST rather than passed to `ok()`. Parenthesize
explicitly or assign the grep result to a variable first (see `t/words.t`).
