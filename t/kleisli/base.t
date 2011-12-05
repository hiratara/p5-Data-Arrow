use strict;
use warnings;
use Test::More;
use Data::Arrow::Kleisli;
use Data::Monad::Maybe;

my $class = Data::Arrow::Kleisli->new_class('Data::Monad::Maybe');
my $arrow10 = $class->arr(sub { 10 });
my $arrow2 = $class->arr(sub { 2 });
my $arrow_div = $class->new(sub {
    $_[1][0] == 0 ? nothing : just ($_[0][0] / $_[1][0]);
});
my $arrow10_div_2 = $arrow10->split($arrow2)->next($arrow_div);

my $maybe = $arrow10_div_2->();
ok ! $maybe->is_nothing;
is $maybe->value, 5;

done_testing;
