package BackWrite::Model::Base;
use Mojo::Base 'ObjectDB';

use DBI;
our $dbh;

sub init_db {
    return $dbh if $dbh;

    #$dbh = DBI->connect('DBI:mysql:database=selc;host=localhost', 'root', '');
    $dbh = DBI->connect('DBI:SQLite:dbname=database.db', undef, undef);
    die $DBI::errorstr unless $dbh;

    return $dbh;
}

1;
