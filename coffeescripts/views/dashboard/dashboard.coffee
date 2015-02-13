define ['jquery', 'backbone', 'templates/dashboard/dashboard', "views/dashboard/header", 'models/dashboard'], ($, Backbone, template, HeaderView, Dashboard) ->
  class DashboadView extends Backbone.View
    initialize: (option) ->
      console.log "waa"
      model = new Dashboard()
      console.log model.get("name")
      @renderDashboard();
      new HeaderView(el: $("[data-js=header]"))

    renderDashboard: ->
      @$el.html template()
