package Eureca;
use Mojo::Base 'Mojolicious';

use DBIx::Custom;
use Eureca::Routes;
use Eureca::Schema;
use Eureca::Helpers;

sub startup {
    my $self = shift;

    $self->helper(
        dbix_custom => sub {
            return DBIx::Custom->connect(
                dsn      => 'dbi:mysql:dbname=eureca;host=localhost',
                user     => 'root',
                password => 'bivee@258'
            );
        }
    );

    $self->helper(
        schema => sub {
            my $self= shift;
            return Eureca::Schema->init_db(@_);
        }
    );

    # Helpers
    Eureca::Helpers->register(context => $self);

    # Router
    Eureca::Routes->register($self->routes);
}

1;
