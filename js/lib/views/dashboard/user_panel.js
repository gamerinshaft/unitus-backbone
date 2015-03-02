var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  __hasProp = {}.hasOwnProperty;

define(['jquery', 'backbone', 'templates/dashboard/user_panel', 'templates/dashboard/user_profile', 'views/dashboard/achivement', 'models/circle'], function($, Backbone, UserTemplate, UserProfile, AchivementView, Circle) {
  var UserPanelView;
  return UserPanelView = (function(_super) {
    __extends(UserPanelView, _super);

    function UserPanelView() {
      this.deleteCircle = __bind(this.deleteCircle, this);
      this.renderCircleList = __bind(this.renderCircleList, this);
      return UserPanelView.__super__.constructor.apply(this, arguments);
    }

    UserPanelView.prototype.initialize = function(option) {
      this.user = option.user;
      this.circles = option.circles;
      this.belongingCircles = this.user.attributes.circles;
      this.notyHelper = new NotyHelper();
      this.renderUserPanel();
      this.renderUserProfile();
      this.renderCircleList();
      new AchivementView({
        el: '[data-js=achivementList]',
        user: this.user
      });
      if (this.belongingCircles.length > 0) {
        return this.renderBelongingCircles();
      }
    };

    UserPanelView.prototype.events = {
      "click [data-js=deleteCircle]": "deleteCircle"
    };

    UserPanelView.prototype.renderUserPanel = function() {
      return this.$el.html(UserTemplate());
    };

    UserPanelView.prototype.renderCircleList = function() {
      var sendData, user;
      user = this.user;
      sendData = {
        count: 40,
        offset: 0
      };
      return $.ajax({
        type: "GET",
        url: "https://core.unitus-ac.com/Circle",
        data: sendData,
        success: (function(_this) {
          return function(msg) {
            var circleRenderer;
            console.log(msg);
            circleRenderer = new CircleRenderView();
            return $.each(msg.Content.Circle, function(index, obj) {
              var circle;
              circle = new Circle({
                CircleID: obj.CircleId,
                CircleName: obj.CircleName,
                MemberCount: obj.MemberCount,
                BelongedUniversity: obj.BelongedUniversity,
                LastUpdateDate: obj.LastUpdateDate,
                IsBelonging: obj.IsBelonging
              });
              _this.circles.add(circle);
              return circleRenderer.renderCircleList(circle, user);
            });
          };
        })(this),
        error: function(msg) {
          return console.log(msg);
        }
      });
    };

    UserPanelView.prototype.renderUserProfile = function() {
      return this.$('[data-js="myProfile"]').html(UserProfile({
        user: this.user
      }));
    };

    UserPanelView.prototype.renderBelongingCircles = function() {
      var textPanel, textSidebar;
      textSidebar = '';
      textPanel = '';
      textSidebar += '<li class="divider"><h1>所属サークル</h1></li>';
      $.each(this.belongingCircles, function() {
        textSidebar += '<li role="presentation" data-commonId="' + this.CircleId + '">';
        textSidebar += '<a href="#' + this.CircleId + '" aria-controls="#' + this.CircleId + '" role="tab" data-toggle="tab">';
        textSidebar += '<i class="circleIcon">' + this.CircleName.slice(0, 1) + '</i>';
        textSidebar += '<span class="title">' + this.CircleName + '</span>';
        textSidebar += '</a>';
        textSidebar += '</li>';
        textPanel += '<div id="' + this.CircleId + '" class="tab-pane fade in" role="tabpanel" data-commonId="' + this.CircleId + '">';
        textPanel += '<h1>' + this.CircleName + '</h1>';
        return textPanel += '</div>';
      });
      $("[data-js=userSideList]").append(textSidebar);
      return $("[data-js=userPanelList]").append(textPanel);
    };

    UserPanelView.prototype.deleteCircle = function(e) {
      var $circleRow, sendData;
      e.preventDefault();
      e.stopPropagation();
      $circleRow = $($($(e.target).get(0)).closest("tr").get(0));
      if (confirm($($circleRow.children("td.name").get(0)).text() + "を削除しますか？")) {
        sendData = {
          circleID: $circleRow.attr("data-circleId")
        };
        return $.ajax({
          type: "DELETE",
          url: "https://core.unitus-ac.com/Circle",
          data: sendData,
          success: (function(_this) {
            return function(msg) {
              var target;
              _this.notyHelper.generate('info', '削除成功', "サークルを削除しました。");
              target = "[data-commonId=" + $circleRow.attr("data-circleId") + "]";
              return $(target).remove();
            };
          })(this),
          error: (function(_this) {
            return function(msg) {
              return _this.notyHelper.generate('error', '削除失敗', "何らかの理由でサークルを削除できませんでした。");
            };
          })(this)
        });
      }
    };

    return UserPanelView;

  })(Backbone.View);
});
