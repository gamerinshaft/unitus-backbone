define ['jquery', 'backbone', 'templates/dashboard/user_profile'], ($, Backbone, Template) ->
  class ProfilebarView extends Backbone.View
    initialize: (option) ->
      @dashboard = option.dashboard
      @renderUserProfile()
      console.log @$el.html()

    events:
      "click [data-js=sendMail]" : "sendMail"

    renderUserProfile: =>
      @$el.html Template(dashboard: @dashboard)

    sendMail: (e)->
      e.preventDefault()
      e.stopPropagation()
      address = $(e.target).text()
      if confirm address + "宛にメールを送信致しますか？"
        location.assign "mailto:" + address

