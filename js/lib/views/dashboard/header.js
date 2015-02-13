var __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  __hasProp = {}.hasOwnProperty;

define(['jquery', 'backbone'], function($, Backbone) {
  var HeaderView;
  return HeaderView = (function(_super) {
    __extends(HeaderView, _super);

    function HeaderView() {
      return HeaderView.__super__.constructor.apply(this, arguments);
    }

    HeaderView.prototype.initialize = function(option) {
      console.log("hogehoge");
      return this.$el.html();
    };

    HeaderView.prototype.events = {
      "click [data-js=dropdown]": "dropdownToggle"
    };

    HeaderView.prototype.dropdownToggle = function(event) {
      console.log("nk");
      return $(event.target).dropdown('toggle');
    };

    return HeaderView;

  })(Backbone.View);
});
