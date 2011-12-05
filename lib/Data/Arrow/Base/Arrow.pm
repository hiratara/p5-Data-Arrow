package Data::Arrow::Base::Arrow;
use strict;
use warnings;

sub arr {
    my ($class, $code) = @_;
    die "not implemented";
}

sub first {
    my $self = shift;
    die "not implemented";
}

sub next {
    my ($self, $arrow) = @_;
    die "not implemented";
}

sub second {
    my $self = shift;
    my $swap = (ref $self)->arr(sub { $_[1], $_[0] });
    $swap->next($self->first)->next($swap);
}

sub parallel {
    my ($self, $arrow) = @_;
    $self->first->next($arrow->second);
}

sub split {
    my ($self, $arrow) = @_;
    (ref $self)->arr(sub {
        my $args = [@_];
        $args, $args;
    })->next($self->parallel($arrow));
}

1;
