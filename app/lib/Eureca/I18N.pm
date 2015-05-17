package Eureca::I18N;
use Mojo::Base -strict;

use Mojo::Loader qw(load_class);

sub new {
    my $class = shift;
    my $args = @_ % 2 == 0 ? {@_} : undef;

    # no language defined
    die "No language defined!" unless $args && $args->{language};

    return bless {
        _language => $args->{language},
        _instance => undef
    }, $class;
}

## accessors
sub language {
    $_[0]->{_language} = $_[1] if $_[1];
    return $_[0]->{_language};
}

sub _instance {
    $_[0]->{_instance} = $_[1] if $_[1];
    return $_[0]->{_instance};
}

## methods
sub _load {
    my ($self, $lang) = @_;

    $lang = $lang || $self->language;
    die "Laguage is not defined" unless $lang;

    my $e = load_class "Eureca::I18N::${lang}";
    #die "Error loading i18n class" if $e;

    my $obj = "Eureca::I18N::${lang}"->new;
    die "Error getting an instance of i18n class ${lang}" unless $obj;

    use Data::Dumper;
    warn Dumper($obj) || 'none';
    return $obj;
}

sub get_string {
    my $self = shift;

    unless($self->_instance){
        my $lang = $self->language;
        $self->_instance($self->_load($lang));
    }

    $self->_instance->get_string($_[0]) if $_[0];
}

1;
