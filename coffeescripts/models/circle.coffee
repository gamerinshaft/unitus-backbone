define ['jquery', 'backbone'], ($, Backbone) ->
  class Circle extends Backbone.Model
    defaults:
      #circleList
      CircleId: ''
      CircleName: '' #必須
      CircleDescription: ''
      Membercount: ''
      BelongedSchool: '' #必須
      IsBelonging: ''

      #detail
      WebAddress: ''
      Notes: ''
      Contact: ''
      CanInterColledge: false
      ActivityDate: ''
      LeaderUserName: '' #必須

      #belonged
      HasAuthority: true
      CircleTags: ''