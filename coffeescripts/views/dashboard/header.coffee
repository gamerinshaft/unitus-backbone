define ['jquery', 'backbone', 'templates/dashboard/header'], ($, Backbone, HeaderTemplate) ->
  class HeaderView extends Backbone.View
    initialize: (option) ->
      @dashboard = option.dashboard
      @admin_panel = option.admin_panel
      @renderTemplate()

    events:
      "click [data-js=dropdown]" : "dropdownToggle"
      "click [data-js=adminToggle]" : "adminOpen"

    renderTemplate: ->
      @$el.html HeaderTemplate(dashboard: @dashboard)
    dropdownToggle: (event)->

    adminOpen: (e)->
      e.preventDefault()
      e.stopPropagation()
      console.log @admin_panel
      @admin_panel.set isOpen: true

