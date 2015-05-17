package Eureca::Controller::User;
use Mojo::Base 'Eureca::Controller::Base';

sub profile {
    my $self = shift;

    my $id = $self->session('uid') || undef;
    return $self->reply->not_found unless $id;

    # getting user
    my $user = $self->schema('User')->find($id);
    return $self->reply->not_found unless $user;

    # success
    return $self->render( user => $user );
}


1;
