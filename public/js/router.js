// Generated by CoffeeScript 1.6.2
(function() {
  var _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  App.Router = (function(_super) {
    __extends(Router, _super);

    function Router() {
      _ref = Router.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    Router.prototype.routes = {
      "": "index",
      "item/:cid": "item"
    };

    Router.prototype.index = function() {
      $(".feed").show();
      return $(".details").hide();
    };

    Router.prototype.item = function(cid) {
      $(".feed").hide();
      $(".details").show();
      return App.Collections.items.details_view.render(cid);
    };

    return Router;

  })(Backbone.Router);

}).call(this);
