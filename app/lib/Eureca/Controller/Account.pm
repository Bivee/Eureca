package Eureca::Controller::Account;
use Mojo::Base 'Eureca::Controller::Base';

use Mojo::JSON;
use Mojo::ByteStream 'b';

sub signin {
    my $self = shift;

    my $user = $self->param('email');
    my $pass  = b($self->param('password'))->sha1_sum
        if $self->param('password');

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
    my $self = shift;

    my $name  = $self->param('name');
    my $email = $self->param('email');
    my $pass  = b($self->param('password'))->sha1_sum
        if $self->param('password');

    if($self->is_post){
        my $user;
        eval {
            $user = $self->schema('User')->create({
                name => $name, email => $email, password => $pass,
            });
        };
    
        # success
        return $self->render(
            message => {
                type => 'success', text => 'User created with success!'
            }
        ) if $user && $user->in_storage;

        # error
        return $self->render( 
            message => {
                type => 'danger', text => 'Error creating user'
            } 
        );
    }

    return $self->render( message => {} );
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
