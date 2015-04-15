use utf8;
package Eureca::Schema::Result::IdeaLike;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Eureca::Schema::Result::IdeaLike

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

=head1 TABLE: C<idea_like>

=cut

__PACKAGE__->table("idea_like");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 user_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=head2 idea_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=head2 created

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "user_id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  "idea_id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  "created",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 0,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<user_idea_UNIQUE>

=over 4

=item * L</user_id>

=item * L</idea_id>

=back

=cut

__PACKAGE__->add_unique_constraint("user_idea_UNIQUE", ["user_id", "idea_id"]);

=head1 RELATIONS

=head2 idea

Type: belongs_to

Related object: L<Eureca::Schema::Result::Idea>

=cut

__PACKAGE__->belongs_to(
  "idea",
  "Eureca::Schema::Result::Idea",
  { id => "idea_id" },
  { is_deferrable => 1, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 user

Type: belongs_to

Related object: L<Eureca::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "user",
  "Eureca::Schema::Result::User",
  { id => "user_id" },
  { is_deferrable => 1, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-04-15 02:02:35
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:sWOB8nrDrSh9H1QIuU2JWg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
