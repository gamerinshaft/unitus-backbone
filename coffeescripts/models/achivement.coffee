define ['jquery', 'backbone'], ($, Backbone) ->
  class Achivement extends Backbone.Model
    defaults:
      Name: '実績名'
      Description: '詳細説明'
      AwardedPerson: '受賞者数'
      AwardedRate: '受賞者率'
      AcuireRateGraphPoints: '達成率の推移グラフ'
      AwardedDate: '取得日'
      BadgeImageUrl: 'バッジ画像'
      CircleStatistics: 'サークルメンバーの進捗状況'
      CurrentProgress: '進捗率'
      IsAwarded: false
      ProgressDiff: '前日差分'
      ProgressGraphPoints: '達成率の変化グラフ'
      SumPerson: 'Unitus合計人数'
      isDetailGetting: false

      #original
      belongedAll: true
      belongedGithub: false