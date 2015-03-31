package Eureca::Controller::API::Idea;
use Mojo::Base 'Eureca::Controller::API::Base';

sub create {
    my $c = shift;

    # getting parans
    my $param = $c->req->json;

    my $user = $c->current_user;
    $param->{user_id} = $user? $user->{id} : undef;


    # TODO: create tags to database

    my $dbi = $c->dbix_custom;
    my $teste = $dbi->insert($param, table => 'idea');

    return $c->render( text => 'teste' );
}

1;
