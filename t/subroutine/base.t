use strict;
use warnings;
use Test::More;
use Data::Arrow::Subroutine;

my $arr3 = Data::Arrow::Subroutine->arr(sub { 3 });
my $arr4 = Data::Arrow::Subroutine->arr(sub { 4 });
my $arrow_add = Data::Arrow::Subroutine->arr(sub {
    $_[0]->[0] + $_[1]->[0];
});
my $arr3_plus_4 = $arr3->split($arr4)->next($arrow_add);

is $arr3_plus_4->(), 7;

done_testing;
