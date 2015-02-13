define ['jquery', 'backbone'], ($, Backbone) ->
  class HeaderView extends Backbone.View
    initialize: (option) ->
      console.log "hogehoge"
      @$el.html()

    events:
      "click [data-js=dropdown]" : "dropdownToggle"

    dropdownToggle: (event)->
      console.log "nk"
      $(event.target).dropdown('toggle')
