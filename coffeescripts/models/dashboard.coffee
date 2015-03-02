define ['jquery', 'backbone'], ($, Backbone) ->
  class Dashboard extends Backbone.Model
    defaults:
      AchivementCategories: ''
      AvatarUri: ''
      CircleBelonging: ''
      IsAdministrator: ''
      Name: ''
      UserName: ''

      #profile
      Profile: ''


      #original
      GithubAssociation: false