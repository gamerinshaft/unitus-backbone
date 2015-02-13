var __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  __hasProp = {}.hasOwnProperty;

define(['jquery', 'backbone', 'templates/dashboard/user_panel'], function($, Backbone, UserTemplate) {
  var UserPanelView;
  return UserPanelView = (function(_super) {
    __extends(UserPanelView, _super);

    function UserPanelView() {
      return UserPanelView.__super__.constructor.apply(this, arguments);
    }

    UserPanelView.prototype.initialize = function(option) {
      var sendData;
      this.renderUserPanel();
      sendData = {
        count: 40,
        offset: 0,
        validationToken: 'abc'
      };
      return $.ajax({
        type: "GET",
        url: "http://unitus-core.azurewebsites.net/Circle/Dummy",
        data: sendData,
        success: function(msg) {
          return $.each(msg.Content.Circle, function() {
            var text;
            console.log(this);
            text = '';
            text += '<tr>';
            text += '<td class="name name_w">' + this.CircleName + '<i class="glyphicon glyphicon-eye-open"></i></td>';
            text += '<td class="author author_w">' + "閲覧者" + '</td>';
            text += '<td class="number number_w">' + this.MemberCount + '</td>';
            text += '<td class="university university_w">' + this.BelongedUniversity + '</td>';
            text += '<td class="update update_w">' + this.LastUpdateDate + '<i class="fa fa-clipboard" data-js="copyMail" data-clipboard-text="' + this.UserName + '"></i></td>';
            text += '</tr>';
            return $("[data-js=circleList]").append(text);
          });
        },
        error: function(msg) {
          return console.log(msg);
        }
      });
    };

    UserPanelView.prototype.renderUserPanel = function() {
      return this.$el.html(UserTemplate());
    };

    return UserPanelView;

  })(Backbone.View);
});
