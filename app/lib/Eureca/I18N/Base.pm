package Eureca::I18N::Base;

sub new { return bless {}, shift }

sub add_string {
    my $class = shift;
    our $args = (@_ % 2 == 0)? {@_} : undef;
}

sub get_string { 
    return $args->{$_[1]}; 
}

1;
