define ['jquery', 'backbone'], ($, Backbone) ->
  class Achivement extends Backbone.Model
    defaults:
      Name: '実績名'
      AwardedDate: '取得日'
      BadgeImageUrl: 'バッジ画像'
      CurrentProgress: '進捗率'
      IsAwarded: false
      ProgressDiff: '前日差分'
