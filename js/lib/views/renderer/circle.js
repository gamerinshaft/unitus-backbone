var __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  __hasProp = {}.hasOwnProperty;

define(['jquery', 'backbone'], function($, Backbone) {
  var CircleRenderView;
  return CircleRenderView = (function(_super) {
    __extends(CircleRenderView, _super);

    function CircleRenderView() {
      return CircleRenderView.__super__.constructor.apply(this, arguments);
    }

    CircleRenderView.prototype.initialize = function(option) {
      this.circles = option.circles;
      this.dashboard = option.dashboard;
      this.listenTo(this.circles, 'add', (function(_this) {
        return function(circle) {
          return _this.renderCircleList(circle, _this.dashboard);
        };
      })(this));
      return this.listenTo(this.circles, 'change', (function(_this) {
        return function(circle) {
          return _this.renderUpdateCircleList(circle, _this.dashboard);
        };
      })(this));
    };

    CircleRenderView.prototype.renderAll = function() {
      return console.log("全てをレンダーするぜ");
    };

    CircleRenderView.prototype.renderCircleList = function(circle, dashboard) {
      var text;
      text = '';
      text += '<tr data-circleListID="' + circle.get("CircleID") + '" data-commonId="' + circle.get("CircleID") + '">';
      text += '<td class="name name_w">' + circle.get("CircleName") + '<i class="glyphicon glyphicon-eye-open"></i></td>';
      text += '<td class="author author_w">' + "閲覧者" + '</td>';
      text += '<td class="number number_w">' + circle.get("MemberCount") + '</td>';
      text += '<td class="university university_w">' + circle.get("BelongedSchool") + '</td>';
      if (dashboard.get("IsAdministrator")) {
        text += '<td class="update update_w">' + circle.get("LastUpdateDate") + '<i class="fa fa-times-circle" data-js="deleteCircle"></i></td>';
      } else {
        text += '<td class="update update_w">' + circle.get("LastUpdateDate") + '</td>';
      }
      text += '</tr>';
      return $("[data-js=circleList]").append(text);
    };

    CircleRenderView.prototype.renderUpdateCircleList = function(circle, dashboard) {
      var text;
      text = '';
      text += '<td class="name name_w">' + circle.get("CircleName") + '<i class="glyphicon glyphicon-eye-open"></i></td>';
      text += '<td class="author author_w">' + "閲覧者" + '</td>';
      text += '<td class="number number_w">' + circle.get("MemberCount") + '</td>';
      text += '<td class="university university_w">' + circle.get("BelongedSchool") + '</td>';
      if (dashboard.get("IsAdministrator")) {
        text += '<td class="update update_w">' + circle.get("LastUpdateDate") + '<i class="fa fa-times-circle" data-js="deleteCircle"></i></td>';
      } else {
        text += '<td class="update update_w">' + circle.get("LastUpdateDate") + '</td>';
      }
      return $("[data-circleListID=" + (circle.get("CircleID")) + "]").html(text);
    };

    CircleRenderView.prototype.renderBelongingCircleSidebar = function() {
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

    return CircleRenderView;

  })(Backbone.View);
});
