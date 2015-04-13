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

sub list {
    my $c = shift;

    # getting page
    my $page = $c->param('page') || 1;

    # getting idea list
    my $model_list = $c->schema('Idea')
        ->search({ active => 1 }, {page => $page, rows => 12});

    # getting pagging data
    my $total = $c->schema('Idea')->count({ active => 1 });

    my $list = [];
    for my $row ($model_list->all) {
        push @$list,
            {
                id          => $row->id,
                user        => {name => $row->user? $row->user->name : ''},
                title       => $row->title,
                slug        => $row->slug,
                description => $row->description,
                comments    => $row->comments || 0,
                likes       => $row->likes || 0,
                created     => $row->created? $row->created->ymd : '1900-01-01',
            };
    }

    return $c->render( json => $list || [] );
}


1;
