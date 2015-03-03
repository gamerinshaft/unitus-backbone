define ['jquery', 'backbone'], ($, Backbone) ->
  class Dashboard extends Backbone.Model
    defaults:
      AchivementCategories: ''
      AvatarUri: ''
      CircleBelonging: ''
      IsAdministrator: ''
      Name: ''
      UserName: ''

      #original
      GithubAssociation: false