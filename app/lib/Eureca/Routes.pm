package Eureca::Routes;
use Mojo::Base -strict;

sub register {
    my ($self, $r) = @_;

    # Account controller
    my $account = $r->any('/account');
    $account->any('/signin')->to('Account#signin');
    $account->get('/signout')->to('Account#signout');
    $account->any('/register')->to('Account#register');
    $account->get('/forgot')->to('Account#forgot');

    # auth area
    my $auth = $r->under(sub{
        my $c = shift;

        return 1 if $c->session('uid');
        $c->flash(error => 'session-expired') 
            && return 0;
    });

    # Home controller
    my $home = $auth->any('/app');
    $home->get('/')->to('Home#index');
}

1;
