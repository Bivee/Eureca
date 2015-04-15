use utf8;
package Eureca::Schema::Result::User;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Eureca::Schema::Result::User

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<user>

=cut

__PACKAGE__->table("user");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 80

=head2 email

  data_type: 'varchar'
  is_nullable: 0
  size: 80

=head2 password

  data_type: 'varchar'
  is_nullable: 0
  size: 150

=head2 about

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 token

  data_type: 'varchar'
  is_nullable: 1
  size: 150

=head2 updated

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 created

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  default_value: 'CURRENT_TIMESTAMP'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 80 },
  "email",
  { data_type => "varchar", is_nullable => 0, size => 80 },
  "password",
  { data_type => "varchar", is_nullable => 0, size => 150 },
  "about",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "token",
  { data_type => "varchar", is_nullable => 1, size => 150 },
  "updated",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  "created",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    default_value => "CURRENT_TIMESTAMP",
    is_nullable => 1,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<email_UNIQUE>

=over 4

=item * L</email>

=back

=cut

__PACKAGE__->add_unique_constraint("email_UNIQUE", ["email"]);

=head1 RELATIONS

=head2 comments

Type: has_many

Related object: L<Eureca::Schema::Result::Comment>

=cut

__PACKAGE__->has_many(
  "comments",
  "Eureca::Schema::Result::Comment",
  { "foreign.user_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 ideas

Type: has_many

Related object: L<Eureca::Schema::Result::Idea>

=cut

__PACKAGE__->has_many(
  "ideas",
  "Eureca::Schema::Result::Idea",
  { "foreign.user_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 ideas_like

Type: has_many

Related object: L<Eureca::Schema::Result::IdeaLike>

=cut

__PACKAGE__->has_many(
  "ideas_like",
  "Eureca::Schema::Result::IdeaLike",
  { "foreign.user_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-04-15 02:02:35
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:1bqBZbUHB+Tu+mG07imWDQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
