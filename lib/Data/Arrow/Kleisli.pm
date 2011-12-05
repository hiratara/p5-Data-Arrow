package Data::Arrow::Kleisli;
use strict;
use warnings;
use parent qw/Data::Arrow::Base::Arrow/;

sub _safe_name($) {
    my $name = shift;
    $name =~ s|::|__|g;
    return "__$name";
}

sub new_class {
    my $class = shift;
    my ($monad) = @_;

    my $class_name = "$class\::" . _safe_name($monad);
    unless ($class_name->isa($class)) {
        no strict qw/refs/;
        @{"$class_name\::ISA"} = ($class);
        *{"$class_name\::monad"} = sub { $monad };
        *{"$class_name\::new_class"} = sub {
            die "Don't call the new_class() method from sub classes.";
        };
    }

    return $class_name;
}

sub monad { die "Implement this method in sub classes" }

sub new {
    my ($class, $kleisli) = @_;
    bless $kleisli, $class;
}

sub arr {
    my ($class, $code) = @_;
    $class->new(sub {
        $class->monad->unit($code->(@_));
    });
}

sub first {
    my $self = shift;
    my $class = (ref $self);
    my $monad = $class->monad;

    $class->new(sub {
        my ($args1, $args2) = @_;
        $monad->sequence(
            $self->(@$args1)->map(sub {[@_]}),
            $monad->unit(@$args2)->map(sub {[@_]}),
        );
    });
}

sub next {
    my ($self, $arrow) = @_;
    (ref $self)->new(sub {
        my @v = @_;
        $self->(@_)->flat_map($arrow);
    });
}

1;
