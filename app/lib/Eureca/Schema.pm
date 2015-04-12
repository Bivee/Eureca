use utf8;
package Eureca::Schema;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Schema';

__PACKAGE__->load_namespaces;


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-03-31 08:54:54
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:n1J6B/1QzLIrIfRxEpPfoA


sub init_db {
    my ($self, $rs) = @_;

    # connection
    my $dbic = __PACKAGE__->connect(
        'dbi:mysql:dbname=eureca;host=localhost', 'root', 'bivee@258'
    );

    # shortcut for resultset
    return $dbic->resultset($rs) if $rs;

    return $dbic;
}

1;
