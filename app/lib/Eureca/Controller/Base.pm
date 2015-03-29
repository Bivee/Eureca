package Eureca::Controller::Base;
use Mojo::Base 'Mojolicious::Controller';

sub is_post {
    return shift->req->method eq 'POST'? 1 : 0;
}


1;
