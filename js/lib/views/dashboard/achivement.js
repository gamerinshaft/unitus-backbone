var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  __hasProp = {}.hasOwnProperty;

define(['jquery', 'backbone', 'models/achivement', 'collections/achivements', 'templates/achivement/index', 'templates/achivement/show'], function($, Backbone, Achivement, Achivements, AchivementListTemplate, AchivementShowTemplate) {
  var AchivementView;
  return AchivementView = (function(_super) {
    __extends(AchivementView, _super);

    function AchivementView() {
      this.achiveShow = __bind(this.achiveShow, this);
      return AchivementView.__super__.constructor.apply(this, arguments);
    }

    AchivementView.prototype.initialize = function(option) {
      this.dashboard = option.dashboard;
      return $.ajax({
        type: "GET",
        url: "https://core.unitus-ac.com/Achivements",
        success: (function(_this) {
          return function(data) {
            var achivements;
            console.log(data);
            _this.achivements = new Achivements();
            achivements = _this.achivements;
            $.each(data.Content.Achivements, function(index, obj) {
              var achivement;
              achivement = new Achivement({
                Name: obj.AchivementName,
                AwardedDate: obj.AwardedDate,
                BadgeImageUrl: obj.BadgeImageUrl,
                CurrentProgress: (obj.CurrentProgress === "NaN" ? null : obj.CurrentProgress.toFixed(2)),
                IsAwarded: obj.IsAwarded,
                ProgressDiff: (obj.ProgressDiff === "NaN" ? null : obj.ProgressDiff.toFixed(2))
              });
              return achivements.add(achivement);
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
      this.achivement = this.achivements.where({
        Name: achive_name
      })[0];
      if (!this.achivement.get("isDetailGetting")) {
        sendData = {
          achivementName: achive_name
        };
        return $.ajax({
          type: "GET",
          url: "https://core.unitus-ac.com/Achivement",
          data: sendData,
          success: (function(_this) {
            return function(data) {
              var values;
              _this.achivement.set({
                isDetailGetting: true
              });
              values = data.Content;
              _this.achivement.set({
                Description: values.AchivementDescription,
                AwardedPerson: values.AwardedPerson,
                AwardedRate: (values.AwardedRate === "NaN" ? null : values.AwardedRate.toFixed(2)),
                AcuireRateGraphPoints: values.AcuireRateGraphPoints,
                AwardedPerson: values.AwardedPerson,
                CircleStatistics: values.CircleStatistics,
                ProgressGraphPoints: values.ProgressGraphPoints,
                SumPerson: values.SumPerson
              });
              return $(_this.$el.children("[data-js=achivementPanel]")[0]).html(AchivementShowTemplate({
                achivement: _this.achivement,
                data: JSON.stringify(_this.achivement),
                dashboard: _this.dashboard
              })).removeClass("hidden_panel_r");
            };
          })(this),
          error: function(data) {
            return console.log(data);
          }
        });
      } else {
        return $(this.$el.children("[data-js=achivementPanel]")[0]).html(AchivementShowTemplate({
          achivement: this.achivement
        })).removeClass("hidden_panel_r");
      }
    };

    AchivementView.prototype.closePanel = function(e) {
      return $(this.$el.children("[data-js=achivementPanel]")[0]).addClass("hidden_panel_r");
    };

    return AchivementView;

  })(Backbone.View);
});
