var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  __hasProp = {}.hasOwnProperty;

define(['jquery', 'backbone', 'models/achivement', 'collections/achivements', 'templates/achivement/index'], function($, Backbone, Achivement, Achivements, AchivementListTemplate) {
  var AchivementView;
  return AchivementView = (function(_super) {
    __extends(AchivementView, _super);

    function AchivementView() {
      this.achiveShow = __bind(this.achiveShow, this);
      return AchivementView.__super__.constructor.apply(this, arguments);
    }

    AchivementView.prototype.initialize = function(option) {
      return $.ajax({
        type: "GET",
        url: "https://core.unitus-ac.com/Achivements",
        success: (function(_this) {
          return function(data) {
            var achivements;
            achivements = new Achivements();
            $.each(data.Content.Achivements, function() {
              var achivement;
              achivement = new Achivement({
                Name: this.AchivementName,
                AwardedDate: this.AwardedDate,
                BadgeImageUrl: this.BadgeImageUrl,
                CurrentProgress: this.CurrentProgress.toFixed(2),
                IsAwarded: this.IsAwarded,
                ProgressDiff: this.ProgressDiff
              });
              achivements.add(achivement);
              return console.log(this.CurrentProgress.toFixed(2));
            });
            return achivements.each(function(a) {
              return _this.$el.append(AchivementListTemplate({
                achivement: a
              }));
            });
          };
        })(this),
        error: function(data) {
          return console.log(data);
        }
      });
    };

    AchivementView.prototype.events = {
      "click [data-js=badge]": "achiveShow",
      "click [data-js=closePanel]": "closePanel"
    };

    AchivementView.prototype.achiveShow = function(e) {
      var achive_name, sendData;
      achive_name = $($(e.currentTarget).children(".achive_name")[0]).text();
      sendData = {
        achivementName: achive_name
      };
      return $.ajax({
        type: "GET",
        url: "https://core.unitus-ac.com/Achivement",
        data: sendData,
        success: (function(_this) {
          return function(data) {
            console.log(_this.$el.children("[data-js=achivementPanel]")[0]);
            return $(_this.$el.children("[data-js=achivementPanel]")[0]).removeClass("hidden_panel");
          };
        })(this),
        error: function(data) {
          return console.log(data);
        }
      });
    };

    AchivementView.prototype.closePanel = function(e) {
      return $(this.$el.children("[data-js=achivementPanel]")[0]).addClass("hidden_panel");
    };

    return AchivementView;

  })(Backbone.View);
});
