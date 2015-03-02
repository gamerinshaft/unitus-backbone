var __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  __hasProp = {}.hasOwnProperty;

define(['jquery', 'backbone', 'templates/dashboard/header'], function($, Backbone, HeaderTemplate) {
  var HeaderView;
  return HeaderView = (function(_super) {
    __extends(HeaderView, _super);

    function HeaderView() {
      return HeaderView.__super__.constructor.apply(this, arguments);
    }

    HeaderView.prototype.initialize = function(option) {
      this.dashboard = option.dashboard;
      this.admin_panel = option.admin_panel;
      this.renderTemplate();
      if (!this.dashboard.get("GithubAssociation")) {
        return this.settingModalOpen();
      }
    };

    HeaderView.prototype.events = {
      "click [data-js=adminToggle]": "adminOpen",
      "click [data-js=setting]": "settingModalOpen",
      "click [data-js=authorizeGithub]": "authorizeGithub"
    };

    HeaderView.prototype.renderTemplate = function() {
      return this.$el.html(HeaderTemplate({
        dashboard: this.dashboard
      }));
    };

    HeaderView.prototype.settingModalOpen = function(e) {
      return $("[data-js=settingModal]").modal("show");
    };

    HeaderView.prototype.adminOpen = function(e) {
      e.preventDefault();
      e.stopPropagation();
      return this.admin_panel.set({
        isOpen: true
      });
    };

    HeaderView.prototype.authorizeGithub = function() {
      e.preventDefault();
      e.stopPropagation();
      return location.assign('https://core.unitus-ac.com/Github/Authorize');
    };

    return HeaderView;

  })(Backbone.View);
});
