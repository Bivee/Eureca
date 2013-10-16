package BackWrite::Controller::Account;
use Mojo::Base 'BackWrite::Controller::Base';

use BackWrite::Service;

# action /account/login
sub signin {
    my $self = shift;

    # form data
    my $model = {
        email    => $self->param('email')    || undef,
        password => $self->param('password') || undef,
    };

    if ( $self->is_post ) {

        # found user
        if($self->authenticate($model->{email}, $model->{password})){
            return $self->redirect_to('/profile');
        }
        else {
            $self->stash( message => 'email or password incorrect' );
        }
    }

    # default render
    return $self->render(
        model   => $model,
        error   => $self->stash('error') || '',
        message => $self->stash('message') || '',
    );
}

# action /account/logout
sub signout {
    my $self = shift;

    # user logout
    $self->logout();

    # redirect default
    return $self->redirect_to('/');
}

1;
