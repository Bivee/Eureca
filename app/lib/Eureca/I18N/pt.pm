package Eureca::I18N::pt;
use Mojo::Base 'Eureca::I18N::Base';
 
__PACKAGE__->add_string(
    website_title => 'Banco de Ideias Colaborativo',
    website_subtitle => 'Somente outro portal de ideias de negócios',

    # menu
    lbl_myideas => 'Minhas Ideias',
    lbl_logout  => 'Sair',

    # forms
    lbl_search          => 'Pesquisar',
    lbl_ideatitle       => 'Titulo',
    lbl_ideaslug        => 'Caminho',
    lbl_ideadescription => 'Descrição',
    lbl_ideatags        => 'Tags',
    btn_postidea        => 'Postar Ideia',

    # notes
    lbl_idea      => 'Ideia',
    lbl_postidea  => 'Postar uma ideia',
    lbl_createdby => 'Criado por',
    lbl_at        => 'em',

    # post idea box
    lbl_wannacolaborate => 'Gostaria de colaborar?',
    lbl_wannacolaborate_descr => 'Clique aqui e publique uma ideia, colabore com a comunidade!',
    btn_wannacolaborate => 'Publicar uma ideia',
);
 
1;
