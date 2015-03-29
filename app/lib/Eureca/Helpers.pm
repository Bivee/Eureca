package Eureca::Helpers;
use Mojo::Base -strict;

sub register {
    my $self = shift;
    my $args = (@_ % 2 == 0) ? {@_} : shift;

    my $c = $args->{context} || undef;
    if ($c) {

        # authentication helpers
        $c->helper(
            current_user => sub {
                my $c = shift;

                my $result = $c->dbix_custom->execute(
                    q{ SELECT * FROM user WHERE id = :id },
                    {id => $c->session('uid') || 0}
                );
                return $result->fetch_hash || undef;
            }
        );
        $c->helper(
            authenticate => sub {
                my ($c, $user, $pass) = @_;

                my $result = $c->dbix_custom->execute(
                    q{ 
                        SELECT id FROM user 
                        WHERE email = :user AND password = :pass
                        LIMIT 1
                    }, {user => $user, pass => $pass}
                );
                my $row = $result->fetch_hash || undef;

                # save user id to session
                $c->session('uid' => $row->{id})
                    if $row->{id};

                return $row && $row->{id}? $row->{id} : 0
            }
        );
        $c->helper(
            logout => sub {
                shift->session(expires => 1);
            }
        );
    }
}

1;
