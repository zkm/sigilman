use strict;
use warnings;
use Test::More;
use FindBin;
use lib "$FindBin::Bin/../lib";

use Sigilman::Words;

my $list = "$FindBin::Bin/fixtures/words.txt";
my $words = Sigilman::Words->new(file => $list);

is($words->count, 3, 'loads expected number of words');

my %seen;
$seen{ $words->random_word }++ for 1 .. 100;
ok(scalar(keys %seen) > 0, 'random_word returns a word');
my @unexpected = grep { !/^(cat|dog|fox)$/ } keys %seen;
ok(!@unexpected, 'only returns known words');

done_testing();
