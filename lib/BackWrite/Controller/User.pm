package BackWrite::Controller::User;
use Mojo::Base 'BackWrite::Controller::Base';

# action /user/:username (user public profile)
sub index {
}

# action /user/create (administrative)
sub create {}

# action /user/edit/:id (administrative)
sub edit {}

# action /user/list (administrative)
sub list {}

# action /user/view/:username (administrative)
sub view {}

# action /user/disable/:id (administrative)
sub disable {}

# action /user/remove/:id (administrative)
sub remove {}

1;
