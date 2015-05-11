use Mojo::Base -strict;

use Test::More;
use Test::Mojo;

my $t = Test::Mojo->new('Eureca');
#$t->get_ok('/')->status_is(200)->content_like(qr/Mojolicious/i);

# /app
$t->get_ok('/app')->status_is(200);

# /app/idea/create
$t->get_ok('/app/idea/create')->status_is(200);

# /app/idea/:slug
$t->get_ok('/app/idea/test-of-love')->status_is(404);

# /app/profile
$t->get_ok('/app/profile')->status_is(200);


done_testing();
