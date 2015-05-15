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
    #my $auth = $r;
    my $auth = $r->under(
        sub {
            my $c = shift;
            return 1 if $c->session('uid');
            $c->flash(error => 'session-expired')
                && return $c->redirect_to('/account/signin');
        }
    );

    # redirect direct to app
    $r->get('/' => sub { shift->redirect_to('/app') });

    # app controller
    my $app = $auth->any('/app');
    $app->get('/')->to('Home#index');
    $app->get('/search')->to('Search#index');
    $app->get('/user/:id')->to('User#index', id => 0);
    $app->any('/idea/create')->to('Idea#create', slug => '');
    $app->get('/idea/:slug')->to('Idea#index', slug => '');
    $app->get('/profile/:slug')->to('User#profile');


    # Api end-points
    my $api = $r->any('/api');
    $api->get('/ideas')->to('API::Idea#list');

    $api->get('/idea')->to('API::Idea#retrieve');
    $api->put('/idea')->to('API::Idea#update');
    $api->post('/idea')->to('API::Idea#create');
}

1;
