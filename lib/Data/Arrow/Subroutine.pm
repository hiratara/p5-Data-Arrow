package Data::Arrow::Subroutine;
use strict;
use warnings;
use parent qw/Data::Arrow::Base::Arrow/;

sub arr {
	my ($class, $code) = @_;
	bless $code, $class;
}

sub first {
	my $self = shift;
	(ref $self)->arr(sub {
		my ($v1, $v2) = @_;
		[$self->(@$v1)], $v2;
	});
}

sub next {
	my ($self, $arrow) = @_;
	(ref $self)->arr(sub { $arrow->($self->(@_)) });
}

1;
