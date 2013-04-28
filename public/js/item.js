// Generated by CoffeeScript 1.6.2
(function() {
  var _ref, _ref1, _ref2, _ref3,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  App.Collections.Items = (function(_super) {
    __extends(Items, _super);

    function Items() {
      _ref = Items.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    Items.prototype.initialize = function() {
      var socket,
        _this = this;

      socket = io.connect();
      socket.on('new-item', function(data) {
        return _this.add(new App.Models.Item({
          title: data.title,
          image: data.image,
          description: data.description,
          category: data.category
        }));
      });
      return this.details_view = new App.Views.Details({
        el: $(".details"),
        collection: this
      });
    };

    return Items;

  })(Backbone.Collection);

  App.Models.Item = (function(_super) {
    __extends(Item, _super);

    function Item() {
      _ref1 = Item.__super__.constructor.apply(this, arguments);
      return _ref1;
    }

    Item.prototype.initialize = function() {
      this.view = new App.Views.Item({
        model: this
      });
      return true;
    };

    return Item;

  })(Backbone.Model);

  App.Views.Item = (function(_super) {
    __extends(Item, _super);

    function Item() {
      _ref2 = Item.__super__.constructor.apply(this, arguments);
      return _ref2;
    }

    Item.prototype.tagName = 'li';

    Item.prototype.events = {
      'click': function() {
        return App.router.navigate("item/" + this.model.cid, {
          trigger: true
        });
      }
    };

    Item.prototype.initialize = function() {
      return this.render();
    };

    Item.prototype.render = function() {
      console.log(this.model.toJSON());
      this.$el.html(_.template($("#item-view").html(), this.model.toJSON()));
      return $("ul").prepend(this.el);
    };

    return Item;

  })(Backbone.View);

  App.Views.Details = (function(_super) {
    __extends(Details, _super);

    function Details() {
      _ref3 = Details.__super__.constructor.apply(this, arguments);
      return _ref3;
    }

    Details.prototype.template = _.template($('#details-view').html(), Details.model.toJSON());

    Details.prototype.events = {
      'click .back': function() {
        return App.router.navigate("/", {
          trigger: true
        });
      }
    };

    Details.prototype.initialize = function(opts) {
      return this.collection = opts.collection;
    };

    Details.prototype.render = function(cid) {
      this.model = this.collection.get(cid);
      if (this.model != null) {
        console.log(this.model);
        return this.$el.find(".info").html(template);
      } else {
        return this.$el.find(".info").html("<h3><em>Sorry, nothing to see here!</em></h3>");
      }
    };

    return Details;

  })(Backbone.View);

}).call(this);
