package Eureca::Controller::Account;
use Mojo::Base 'Eureca::Controller::Base';

use Mojo::JSON;

sub signin {
    my $self = shift;

    my $user = $self->param('email');
    my $pass = $self->param('password');

    if($self->is_post){
        if($self->authenticate($user, $pass)){
            return $self->redirect_to('/app');
        }
        else {
            return $self->render( 
                message => {
                    type => 'danger',
                    text => 'Email or password wrong'
                } 
            );
        }
    }

    return $self->render( message => {} );
}

sub register {

}

sub signout {
    my $c = shift;
    $c->logout;

    # ajax request
    return $c->render(
        json => { logout => Mojo::JSON->true }
    ) if $c->req->headers->header('X-Requested-With') eq 'XMLHttpRequest';

    # http request
    return $c->redirect_to( $c->param('returnto') || '/' );
}

sub forgot {

}

sub change_password {

}


1;
