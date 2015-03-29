package Eureca::Controller::Account;
use Mojo::Base 'Eureca::Controller::Base';

use Mojo::JSON;

sub signin {
    my $c = shift;

    my $user = $c->param('email');
    my $pass = $c->param('password');

    if($c->is_post){
        if($c->authenticate($user, $pass)){
            return $c->redirect_to('/app');
        }
        else {
            return $c->render( message => {text => 'Email or password wrong'} );
        }
    }
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
