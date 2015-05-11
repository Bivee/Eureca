package Eureca::Controller::API::Idea;
use Mojo::Base 'Eureca::Controller::API::Base';

use DateTime;

sub create {
    my $c = shift;

    # getting parans
    my $param = $c->req->json;
    my $user  = $c->current_user;

    my $model = $c->schema('Idea')->create({
            user_id => $user ? $user->{id} : undef,
            title   => $param->{title},
            slug    => $param->{slug},
            description => $param->{description},
            created     => DateTime->now(time_zone => 'local')
        }
    );

    # TODO: create tags to database

    # success
    return $c->render(status => 200, json => {id => $model->id})
        if $model && $model->in_storage;

    # error
    return $c->render(status => 400,
        json => {message => 'Error saving idea'});
}

sub retrieve {
    my $c = shift;

    my $id   = $c->param('id')   || 0;
    my $slug = $c->param('slug') || undef;

    my $model = $c->schema('Idea')
        ->find({active => 1, ($id ? 'id' : 'slug') => ($id ? $id : $slug)});

    # error: not found
    return $c->render(status => 400, json => {message => 'Idea not found'})
        unless $model;

    $model = {
        id   => $model->id,
        user => {
            id   => ($model       ? $model->user->id   : 0),
            name => ($model->user ? $model->user->name : '')
        },
        title       => $model->title,
        slug        => $model->slug,
        description => $model->description,
        comments    => $model->comments || 0,
        likes       => $model->likes || 0,
        tags        => [split(/;/, $model->tags)] || [],
        created     => $model->created
        ? $model->created->ymd . ' ' . $model->created->hms
        : '1900-01-01 00:00:00',
    };

    return $c->render(json => $model || {});
}

sub list {
    my $c = shift;

    # getting page
    my $page = $c->param('page') || 1;
    my $term = $c->param('term') || '';

    # getting idea list
    my $model_list;
    $model_list
        = $c->schema('Idea')
        ->search({description => {like => "%${term}%"}, active => 1},
        {page => $page, rows => 12})
        if $term;
    $model_list
        = $c->schema('Idea')
        ->search({active => 1}, {page => $page, rows => 12})
        unless $term;

    # getting pagging data
    my $total;
    $total
        = $c->schema('Idea')
        ->count({description => {like => "%${term}%"}, active => 1})
        if $term;
    $total = $c->schema('Idea')->count({active => 1}) unless $term;

    my $list = [];
    for my $row ($model_list->all) {
        push @$list,
            {
            id   => $row->id,
            user => {
                id   => ($row       ? $row->user->id   : 0),
                name => ($row->user ? $row->user->name : '')
            },
            title       => $row->title,
            slug        => $row->slug,
            description => $row->description,
            comments    => $row->comments || 0,
            likes       => $row->likes || 0,
            created     => $row->created ? $row->created->ymd : '1900-01-01',
            };
    }

    return $c->render(json => {data => $list, count => $total || 0});
}


1;
