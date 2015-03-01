define ['jquery', 'backbone'], ($, Backbone) ->
  class Circle extends Backbone.Model
    defaults:
      CircleName: '' #必須
      CircleDescription: ''
      Membercount: ''
      WebAddress: ''
      BelongedSchool: '' #必須
      Notes: ''
      Contact: ''
      CanInterColledge: false
      ActivityDate: ''
      LeaderUserName: '' #必須

