var __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  __hasProp = {}.hasOwnProperty;

define(['jquery', 'backbone', 'templates/dashboard/dashboard', 'views/dashboard/header', 'views/dashboard/panel', 'models/user', 'models/admin_panel', 'collections/circles'], function($, Backbone, template, HeaderView, PanelView, User, AdminPanel, Circles) {
  var DashboadView;
  return DashboadView = (function(_super) {
    __extends(DashboadView, _super);

    function DashboadView() {
      return DashboadView.__super__.constructor.apply(this, arguments);
    }

    DashboadView.prototype.initialize = function(option) {
      this.user = new User();
      this.circles = new Circles();
      $.ajaxSetup({
        xhrFields: {
          withCredentials: true
        },
        dataType: 'json',
        data: {
          ValidationToken: 'abc'
        }
      });
      return $.ajax({
        url: 'https://core.unitus-ac.com/Dashboard',
        type: 'GET',
        success: (function(_this) {
          return function(msg) {
            var data;
            console.log(msg);
            $("[data-js=loading]").fadeOut();
            data = msg.Content;
            _this.user.set({
              name: data.Name
            });
            _this.user.set({
              mail: data.UserName
            });
            _this.user.set({
              avatar: data.AvatarUri
            });
            _this.user.set({
              isAdmin: data.IsAdministrator
            });
            _this.user.set({
              circles: data.CircleBelonging
            });
            if (_this.user.get("isAdmin")) {
              _this.admin_panel = new AdminPanel();
            }
            _this.renderDashboard();
            new HeaderView({
              el: $("[data-js=header]"),
              user: _this.user,
              admin_panel: _this.admin_panel
            });
            new PanelView({
              el: $("[data-js=panel]"),
              user: _this.user,
              admin_panel: _this.admin_panel,
              circles: _this.circles
            });
            return _this.$el.fadeIn();
          };
        })(this),
        error: function(XMLHttpRequest, textStatus) {
          console.log(XMLHttpRequest);
          console.log(textStatus);
          if (textStatus === "error" || XMLHttpRequest.ErrorMessage === "Unauthorized API Access") {
            return location.assign("https://core.unitus-ac.com/Account/Login");
          }
        }
      });
    };

    DashboadView.prototype.renderDashboard = function() {
      return this.$el.html(template({
        user: this.user
      }));
    };

    return DashboadView;

  })(Backbone.View);
});
