package Eureca::Controller::Idea;
use Mojo::Base 'Eureca::Controller::Base';

sub index {
    my $c = shift;

    my $model = $c->schema('Idea')
        ->find({active => 1, slug => $c->param('slug') });

    # error: not found
    return $c->reply->not_found unless $model;

    # success
    return $c->render( idea => $model )
}


1;
