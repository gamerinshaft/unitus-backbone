define ['jquery', 'backbone', 'templates/dashboard/header'], ($, Backbone, HeaderTemplate) ->
  class HeaderView extends Backbone.View
    initialize: (option) ->
      @user = option.user
      @admin_panel = option.admin_panel
      @renderTemplate()

    events:
      "click [data-js=dropdown]" : "dropdownToggle"
      "click [data-js=adminToggle]" : "adminOpen"

    renderTemplate: ->
      @$el.html HeaderTemplate(user: @user)
    dropdownToggle: (event)->

    adminOpen: (e)->
      e.preventDefault()
      e.stopPropagation()

      @admin_panel.set isOpen: true

