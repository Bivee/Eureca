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
** Backbone Views
******************************************************/
Eureca.View.Home = Backbone.View.extend({
    el : '#app-container',

    events : {
        'mouseover .note-item' : "note_item_mouseover",
        'mouseout .note-item' : "note_item_mouseout"
    },

    initialize: function(){
        this.$el.find('.note-item').on('mouseover', function(){
            $(this).find('.note-controls').removeClass('invisible');
            return false;
        });
        this.$el.find('.note-item').on('mouseout', function(){
            $(this).find('.note-controls').addClass('invisible');
            return false;
        });
    },

    note_item_mouseover : function(e, el){
        e.stopPropagation();
        console.log(el);
        $(el).find('.note-controls').removeClass('invisible');
        return false;
    },

    note_item_mouseout : function(){
        $(this).find('.note-controls').addClass('invisible');
        return false;
    },

    render : function(){
        var template = new Template();
        template.loadTemplate('/home/index', function(data){
            $('#app-container').html(data);
        });
    }
});

Eureca.Router = Backbone.Router.extend({
    routes: {
      "" : "home"
    },
  
    home : function() {
        var view = new Eureca.View.Home();
        view.render();
    }
});

$(function(){
    Eureca.app = new Eureca.Router();
    Backbone.history.start();
});
