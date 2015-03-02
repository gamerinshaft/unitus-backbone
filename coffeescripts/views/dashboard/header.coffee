define ['jquery', 'backbone', 'templates/dashboard/header'], ($, Backbone, HeaderTemplate) ->
  class HeaderView extends Backbone.View
    initialize: (option) ->
      @dashboard = option.dashboard
      @admin_panel = option.admin_panel
      @renderTemplate()

    events:
      "click [data-js=adminToggle]" : "adminOpen"
      "click [data-js=setting]" : "settingModalOpen"

    renderTemplate: ->
      @$el.html HeaderTemplate(dashboard: @dashboard)

    settingModalOpen: (e)->
      e.preventDefault()
      e.stopPropagation()
      $("[data-js=settingModal]").modal("show")


    adminOpen: (e)->
      e.preventDefault()
      e.stopPropagation()
      console.log @admin_panel
      @admin_panel.set isOpen: true

