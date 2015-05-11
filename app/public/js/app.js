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

    defaults: {}
    //defaults: {
    //    user        : { name : '' },
    //    title       : '',
    //    slug        : '',
    //    description : '',
    //    comments    : '',
    //    likes       : '',
    //    created     : '',
    //}
    
});
Eureca.Collection.Ideas = Backbone.Collection.extend({
    url: '/api/ideas',

    model : Eureca.Model.Idea,

    parse: function(response){
        return response;
    }
});

/*****************************************************
** Backbone Views
******************************************************/
Eureca.View.Home = Backbone.View.extend({
    model  : new Eureca.Collection.Ideas(),

    el     : '#app-container',

    events : { 
        'click .note': 'note_click'
    },

    note_click: function(e){
        e.preventDefault();
        document.location = '/app/idea/' + $(e.currentTarget).attr('data-uri');
        return false;
    }

});
Eureca.View.IdeaIndex = Backbone.View.extend({
    el : '#app-container'

});
Eureca.View.IdeaCreate = Backbone.View.extend({
    el : '#app-container',

    events : { 
        'click #btn-save-idea' : 'save_idea_click',
        'keyup #idea-title'    : 'slug_generation'
    },

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
        var string = $(e.currentTarget).val();

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

        $('#idea-slug').val(string);
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
    }
});


Eureca.Router = Backbone.Router.extend({
    routes: {
      ""                : "home",
      "search"          : "search_page",
      "search/p:page"   : "search_page",
      "profile/ideas"   : "profile_ideas",
      "idea/create"     : "idea_create",
      "idea/item/:slug" : "idea_index"
    },
  
    home : function() {
        var view = new Eureca.View.Home();
        view.render();
        return false;
    },

    search_page : function (page) {
        alert('Search Page: '+ page);
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

//$(function(){
//    Eureca.app = new Eureca.Router();
//    Backbone.history.start();
//});
