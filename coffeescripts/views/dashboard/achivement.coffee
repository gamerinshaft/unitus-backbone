define ['jquery', 'backbone','models/achivement', 'collections/achivements', 'templates/achivement/index'], ($, Backbone, Achivement, Achivements, AchivementListTemplate) ->
  class AchivementView extends Backbone.View
    initialize: (option) ->
      $.ajax
        type: "GET",
        url:"https://core.unitus-ac.com/Achivements",
        success: (data)=>
          achivements = new Achivements()
          $.each data.Content.Achivements, ->
            achivement = new Achivement(Name: this.AchivementName, AwardedDate: this.AwardedDate, BadgeImageUrl: this.BadgeImageUrl, CurrentProgress: this.CurrentProgress.toFixed(2), IsAwarded: this.IsAwarded, ProgressDiff: this.ProgressDiff)
            achivements.add achivement
            console.log this.CurrentProgress.toFixed(2)
          achivements.each (a) =>
            @$el.append AchivementListTemplate(achivement: a)
        error: (data)->
          console.log data
    events:
      "click [data-js=badge]" : "achiveShow"
      "click [data-js=closePanel]" : "closePanel"

    achiveShow: (e)=>
      achive_name = $($(e.currentTarget).children(".achive_name")[0]).text()
      sendData =
        achivementName: achive_name
      $.ajax
        type: "GET",
        url:"https://core.unitus-ac.com/Achivement",
        data: sendData,
        success: (data)=>
          console.log @$el.children("[data-js=achivementPanel]")[0]
          $(@$el.children("[data-js=achivementPanel]")[0]).removeClass("hidden_panel")
        error: (data)->
          console.log data

    closePanel: (e)->
      $(@$el.children("[data-js=achivementPanel]")[0]).addClass("hidden_panel")