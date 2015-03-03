define ['jquery', 'backbone', 'templates/dashboard/user_profile'], ($, Backbone, Template) ->
  class ProfilebarView extends Backbone.View
    initialize: (option) ->
      @dashboard = option.dashboard
      @renderUserProfile()
    renderUserProfile: =>
      @$el.html Template(dashboard: @dashboard)
