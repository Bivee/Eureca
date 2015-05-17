package Eureca::I18N::en;
use Mojo::Base 'Eureca::I18N::Base';
 
__PACKAGE__->add_string(
    website_title => 'Colaborative Idea Database',
    website_subtitle => 'Yet another business colaborative portal',

    # menu
    lbl_myideas => 'My Ideas',
    lbl_logout  => 'Logout',

    # forms
    lbl_search          => 'Search',
    lbl_ideatitle       => 'Title',
    lbl_ideaslug        => 'Slug',
    lbl_ideadescription => 'Description',
    lbl_ideatags        => 'Tags',
    btn_postidea        => 'Post idea',

    # notes
    lbl_idea      => 'Idea',
    lbl_postidea  => 'Post an idea',
    lbl_createdby => 'Created by',
    lbl_at        => 'at',

    # post idea box
    lbl_wannacolaborate => 'Do you want colaborate?',
    lbl_wannacolaborate_descr => 'Click here and post an idea, colaborate with the community!',
    btn_wannacolaborate => 'Post an idea',
);
 
1;
