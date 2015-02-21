define ['jquery', 'backbone'], ($, Backbone) ->
  class Circle extends Backbone.Model
    defaults:
      CircleName: '応用数学研究部'
      CircleDescription: ''
      Membercount: 5
      WebAddress: 'hoge.com'
      BelongedSchool: '東京理科大学'
      Notes: 'サークルじゃなくて部活です。'
      Contact: 'twitter: @_HTTP418'
      CanInterColledge: true
      ActivityDate: 'FRYDAY'


