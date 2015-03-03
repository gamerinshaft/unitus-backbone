var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  __hasProp = {}.hasOwnProperty;

define(['jquery', 'backbone', 'templates/dashboard/user_profile'], function($, Backbone, Template) {
  var ProfilebarView;
  return ProfilebarView = (function(_super) {
    __extends(ProfilebarView, _super);

    function ProfilebarView() {
      this.renderUserProfile = __bind(this.renderUserProfile, this);
      return ProfilebarView.__super__.constructor.apply(this, arguments);
    }

    ProfilebarView.prototype.initialize = function(option) {
      this.dashboard = option.dashboard;
      return this.renderUserProfile();
    };

    ProfilebarView.prototype.renderUserProfile = function() {
      return this.$el.html(Template({
        dashboard: this.dashboard
      }));
    };

    return ProfilebarView;

  })(Backbone.View);
});
