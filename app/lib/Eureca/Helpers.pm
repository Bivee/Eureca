package Eureca::Helpers;
use Mojo::Base -strict;

use Eureca::I18N;

sub register {
    my $self = shift;
    my $args = (@_ % 2 == 0) ? {@_} : shift;

    my $c = $args->{context} || undef;
    if ($c) {

        # authentication helpers
        $c->helper(
            current_user => sub {
                my $self = shift;
                return $self->schema('User')->find($self->session('uid'));
            }
        );
        $c->helper(
            authenticate => sub {
                my ($self, $email, $pass) = @_;

                my $user = $self->schema('User')->find({
                    email => $email, password => $pass
                });

                $self->session('uid' => $user->id) if $user && $user->id;
                return $user && $user->id? $user->id : 0
            }
        );
        $c->helper(
            logout => sub {
                my $self = shift;
                $self->session(expires => 1);
            }
        );
        $c->helper(
            l => sub {
                my $self = shift;
                my $lang = $self->session('lang') || 'en';

                my $i18n = Eureca::I18N->new( language => $lang );
                return $i18n->get_string($_[0]) if $_[0];
            }
        )
    }
}

1;
