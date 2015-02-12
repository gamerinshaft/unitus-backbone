define ['jquery', 'backbone', 'templates/dashboard/dashboard'], ($, Backbone, template) ->
  class DashboadView extends Backbone.View
    initialize: (option) ->
      console.log("hs")
      @renderDashboard();
      console.log("this")
    renderDashboard: ->
      @$el.html template()
