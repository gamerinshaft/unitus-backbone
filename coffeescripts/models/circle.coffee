define ['jquery', 'backbone'], ($, Backbone) ->
  class Circle extends Backbone.Model
    defaults:
      CircleId: ''
      CircleName: '' #必須
      CircleDescription: ''
      Membercount: ''
      BelongedSchool: '' #必須
      IsBelonging: ''

      WebAddress: ''
      Notes: ''
      Contact: ''
      CanInterColledge: false
      ActivityDate: ''
      LeaderUserName: '' #必須



