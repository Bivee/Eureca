use utf8;
package Eureca::Schema::Result::Idea;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Eureca::Schema::Result::Idea

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

=head1 TABLE: C<idea>

=cut

__PACKAGE__->table("idea");

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

=head2 title

  data_type: 'varchar'
  is_nullable: 0
  size: 100

=head2 slug

  data_type: 'varchar'
  is_nullable: 0
  size: 100

=head2 description

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 comments

  data_type: 'integer'
  default_value: 0
  extra: {unsigned => 1}
  is_nullable: 1

=head2 likes

  data_type: 'integer'
  default_value: 0
  extra: {unsigned => 1}
  is_nullable: 1

=head2 tags

  data_type: 'varchar'
  is_nullable: 1
  size: 200

=head2 active

  data_type: 'tinyint'
  default_value: 1
  extra: {unsigned => 1}
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
  "user_id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  "title",
  { data_type => "varchar", is_nullable => 0, size => 100 },
  "slug",
  { data_type => "varchar", is_nullable => 0, size => 100 },
  "description",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "comments",
  {
    data_type => "integer",
    default_value => 0,
    extra => { unsigned => 1 },
    is_nullable => 1,
  },
  "likes",
  {
    data_type => "integer",
    default_value => 0,
    extra => { unsigned => 1 },
    is_nullable => 1,
  },
  "tags",
  { data_type => "varchar", is_nullable => 1, size => 200 },
  "active",
  {
    data_type => "tinyint",
    default_value => 1,
    extra => { unsigned => 1 },
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

=head2 C<slug_UNIQUE>

=over 4

=item * L</slug>

=back

=cut

__PACKAGE__->add_unique_constraint("slug_UNIQUE", ["slug"]);

=head1 RELATIONS

=head2 comments

Type: has_many

Related object: L<Eureca::Schema::Result::Comment>

=cut

__PACKAGE__->has_many(
  "comments",
  "Eureca::Schema::Result::Comment",
  { "foreign.idea_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 idea_tags

Type: has_many

Related object: L<Eureca::Schema::Result::IdeaTag>

=cut

__PACKAGE__->has_many(
  "idea_tags",
  "Eureca::Schema::Result::IdeaTag",
  { "foreign.idea_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
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


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-03-31 08:54:54
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:GUaTby1XM2pVV83tzG35gQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
