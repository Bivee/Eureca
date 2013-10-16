package BackWrite;
use Mojo::Base 'Mojolicious';

use BackWrite::Routes;
use BackWrite::Authentication;

sub startup {
    my $self = shift;

    # load auth plugin
    $self->plugin('authentication' => {
        'autoload_user' => 1,
        'session_key' => 'my_eureka_portal_bitch',
        'load_user' => sub {
           return BackWrite::Authentication->load_user(@_);
        },
        'validate_user' => sub {
           return BackWrite::Authentication->validate_user(@_);
        },
    });

    # Router
    my $r = $self->routes;
    $r->namespaces( ['BackWrite::Controller'] );

    # default route to controller
    $r->get('/')->to('Home#index');

    BackWrite::Routes->load($r);
}

1;
