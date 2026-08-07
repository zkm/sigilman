use strict;
use warnings;
use Test::More;
use FindBin;
use lib "$FindBin::Bin/../lib";

use Sigilman::Game;

my $game = Sigilman::Game->new(word => 'perl', max_attempts => 3);

is($game->masked_word, '_ _ _ _', 'starts fully masked');
is($game->guess('p'), 'correct', 'correct letter reported');
is($game->masked_word, 'p _ _ _', 'reveals guessed letter');
is($game->guess('p'), 'already_guessed', 'repeat guess detected');
is($game->guess('z'), 'incorrect', 'wrong letter reported');
is($game->wrong_count, 1, 'wrong count increments');
is($game->guess('1'), 'invalid', 'non-letter input rejected');

$game->guess('e');
$game->guess('r');
$game->guess('l');
ok($game->is_won, 'game won once all letters guessed');
ok(!$game->is_lost, 'not lost when won');

my $lost = Sigilman::Game->new(word => 'ab', max_attempts => 2);
$lost->guess('x');
$lost->guess('y');
ok($lost->is_lost, 'game lost after exhausting attempts');
ok(!$lost->is_won, 'not won when lost');

done_testing();
