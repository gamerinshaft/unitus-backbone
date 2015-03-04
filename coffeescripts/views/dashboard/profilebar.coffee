define ['jquery', 'backbone', 'templates/dashboard/user_profile'], ($, Backbone, Template) ->
  class ProfilebarView extends Backbone.View
    initialize: (option) ->
      @dashboard = option.dashboard
      @achivements = option.achivements
      @renderUserProfile()
      console.log @dashboard
    events:
      "click [data-js=sendMail]" : "sendMail"
      "click [data-js=achivementCategory]" : "renderCategoryAchivement"
    renderUserProfile: =>
      @$el.html Template(dashboard: @dashboard)

    sendMail: (e)->
      e.preventDefault()
      e.stopPropagation()
      address = $(e.target).text()
      if confirm address + "宛にメールを送信致しますか？"
        location.assign "mailto:" + address

    renderCategoryAchivement: (e)->
      e.preventDefault()
      e.stopPropagation()
      @$($(e.target)).parent("a").tab('show')

