var Template = function(){
    this.loadTemplate = function (uri, callback) {
        $.get('/templates' + uri + '-tmpl.html', callback, 'html');
    }
};

/* namespaces */
var Eureca      = Eureca            = {};
var View        = Eureca.View       = {};
var Model       = Eureca.Model      = {};
var Collection  = Eureca.Collection = {};

/*****************************************************
** Backbone Model
******************************************************/
Eureca.Model.Idea = Backbone.Model.extend({
    url: '/api/idea',

    defaults: {
        user        : { name : '' },
        title       : '',
        slug        : '',
        description : '',
        comments    : '',
        likes       : '',
        created     : '',
    }
    
});
Eureca.Collection.Ideas = Backbone.Collection.extend({
    url: '/api/ideas',
    model : Eureca.Model.Idea
});

/*****************************************************
** Backbone Views
******************************************************/
Eureca.View.Home = Backbone.View.extend({
    model  : new Eureca.Collection.Ideas(),

    el     : '#app-container',

    events : { 
        'mouseover .note-item': 'note_item_mouseover',
        'mouseout .note-item':  'note_item_mouseout',
        'click .note': 'note_click'
    },

    note_item_mouseover: function(e){
        e.preventDefault();

        var $c = $(e.currentTarget);
        $c.find('.note-controls').removeClass('invisible');
        return false;
    },

    note_item_mouseout: function(e){
        e.preventDefault();

        var $c = $(e.currentTarget);
        $c.find('.note-controls').addClass('invisible');
        return false;
    },

    note_click: function(e){
        e.preventDefault();

        var app = Eureca.app || new Eureca.Router();

        var $c = $(e.currentTarget);
        var slug = $c.attr('data-uri');
        app.navigate("/idea/item/" + slug, {trigger: true});
        return false;
    },

    render : function(){
        this.model.fetch({
            success: function(data){
                var model_list = data.toJSON() || [];

                var template = new Template();
                template.loadTemplate('/home/index', function(data){
                    var template = Handlebars.compile(data);
                    $('#app-container').html(template({ 'models': model_list }));
                });
            },
            error: function(){
                alert('Error fetching idea list');
            }
        });
    }
});
Eureca.View.IdeaIndex = Backbone.View.extend({
    model  : new Eureca.Model.Idea(),

    el : '#app-container',

    events : { },

    initialize: function () { },

    render : function(param){
        this.model = new Eureca.Model.Idea({ 
            slug: param.slug 
        });

        this.model.fetch({
            data: { 'slug': param.slug },
            success: function(data){
                var model = data.toJSON() || [];

                var template = new Template();
                template.loadTemplate('/idea/index', function(data){
                    var template = Handlebars.compile(data);
                    $('#app-container').html(template( model ));
                });
            },
            error: function(){
                alert('Error retrieving idea data');
            }
        });
    }
});
Eureca.View.IdeaCreate = Backbone.View.extend({
    el : '#app-container',

    events : { 
        'click #btn-save-idea' : 'save_idea_click',
        'keyup #idea-title'    : 'slug_generation'
    },

    initialize: function(){ },

    save_idea_click: function () {
        var data = this.form_to_json('#form-idea-create');
        
        var model = new Eureca.Model.Idea();
        model.save(
            data, {
            success: function(model, res){
                alert('Success save');
            },
            error: function(model, res){
                alert('Error save');
            }
        });
    },

    slug_generation: function (e) {
        var string = $('#idea-title').val();

        var a_chars = new Array(
            new Array("a",/[áàâãªÁÀÂÃ]/g),
            new Array("e",/[éèêÉÈÊ]/g),
            new Array("i",/[íìîÍÌÎ]/g),
            new Array("o",/[òóôõºÓÒÔÕ]/g),
            new Array("u",/[úùûÚÙÛ]/g),
            new Array("c",/[çÇ]/g),
            new Array("n",/[Ññ]/g)
        );

        for(var i in a_chars){
            string = string.replace(i[1], i[0]);
        }

        string = string.toLowerCase();
        string = string.replace(/\s+/g,'-')   // space to dash
            .replace(/[^a-z0-9\-]/g, '')    // remove special chars
            .replace(/\-{2,}/g,'-')         // remove duplicated dashes
            .replace(/(^\s*)|(\s*$)/g, '');  // trim right and left       

        $(e.currentTarget).val(string);
        return false;
    },

    form_to_json: function(id){
        var $form = $(id);
        return {
            title      : $form.find('#idea-title').val(),
            slug       : $form.find('#idea-slug').val(),
            description: $form.find('#idea-description').val(),
            tags       : $form.find('#idea-tags').val(),
        }
    },

    render : function(){
        var template = new Template();
        template.loadTemplate('/idea/create', function(data){
            $('#app-container').html(data);
        });
    }
});


Eureca.Router = Backbone.Router.extend({
    routes: {
      ""                : "home",
      "profile"         : "profile",
      "profile/:id"     : "profile_user",
      "profile/ideas"   : "profile_ideas",
      "idea/create"     : "idea_create",
      "idea/item/:slug" : "idea_index"
    },
  
    home : function() {
        var view = new Eureca.View.Home();
        view.render();
        return false;
    },

    profile : function () {
        var view = new Eureca.View.Profile();
        view.render();
        return false;
    },

    profile_user : function () {
        alert('Profile User');
        return false;
    },

    profile_ideas : function () {
        var view = new Eureca.View.ProfileIdeas();
        view.render();
        return false;
    },

    idea_create : function(){
        var view = new Eureca.View.IdeaCreate();
        view.render();
        return false;
    },

    idea_index : function(slug){
        var view = new Eureca.View.IdeaIndex();
        view.render({'slug': slug});
        return false;
    }
});

$(function(){
    Eureca.app = new Eureca.Router();
    Backbone.history.start();
});
