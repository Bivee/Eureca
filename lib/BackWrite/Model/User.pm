package BackWrite::Model::User;
use Mojo::Base 'BackWrite::Model::Base';

__PACKAGE__->schema(
    table          => 'user',
    columns        => [qw/id name email password image about token change active created/],
    primary_keys   => ['id'],
    auto_increment => 'id',
);

1;




