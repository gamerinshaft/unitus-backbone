define ['jquery', 'backbone', 'models/achivement', 'collections/achivements', 'templates/achivement/index', 'templates/achivement/show'], ($, Backbone, Achivement, Achivements, AchivementListTemplate, AchivementShowTemplate) ->
  class AchivementView extends Backbone.View
    initialize: (option) ->
      $.ajax
        type: "GET",
        url:"https://core.unitus-ac.com/Achivements",
        success: (data)=>
          @achivements = new Achivements()
          achivements = @achivements
          $.each data.Content.Achivements, ->
            achivement = new Achivement(Name: this.AchivementName, AwardedDate: this.AwardedDate, BadgeImageUrl: this.BadgeImageUrl, CurrentProgress: this.CurrentProgress.toFixed(2), IsAwarded: this.IsAwarded, ProgressDiff: this.ProgressDiff.toFixed(2))
            achivements.add achivement
          achivements.each (a) =>
            @$el.append AchivementListTemplate(achivement: a)
        error: (data)->
          console.log data
    events:
      "click [data-js=badge]" : "achiveShow"
      "click [data-js=closePanel]" : "closePanel"

    achiveShow: (e)=>
      achive_name = $($(e.currentTarget).children(".achive_name")[0]).text()
      @achivement = @achivements.where(Name: achive_name)[0]
      unless @achivement.get("isDetailGetting")
        sendData =
          achivementName: achive_name
        $.ajax
          type: "GET",
          url:"https://core.unitus-ac.com/Achivement",
          data: sendData,
          success: (data)=>
            @achivement.set(isDetailGetting: true)
            values = data.Content
            @achivement.set(Description: values.AchivementDescription, AwardedPerson: values.AwardedPerson, AwardedRate: values.AwardedRate.toFixed(2), AcuireRateGraphPoints: values.AcuireRateGraphPoints, AwardedPerson: values.AwardedPerson,  CircleStatistics: values.CircleStatistics, ProgressGraphPoints: values.ProgressGraphPoints, SumPerson: values.SumPerson)
            $(@$el.children("[data-js=achivementPanel]")[0])
            .html AchivementShowTemplate(achivement: @achivement)
            .removeClass("hidden_panel_r")
          error: (data)->
            console.log data
      else
        $(@$el.children("[data-js=achivementPanel]")[0])
        .html AchivementShowTemplate(achivement: @achivement)
        .removeClass("hidden_panel_r")
        console.log "取得済み"

    closePanel: (e)->
      $(@$el.children("[data-js=achivementPanel]")[0]).addClass("hidden_panel_r")

