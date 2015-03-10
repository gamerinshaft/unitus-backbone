define ['jquery', 'backbone', 'models/achivement', 'templates/achivement/index', 'templates/achivement/show'], ($, Backbone, Achivement, AchivementListTemplate, AchivementShowTemplate) ->
  class AchivementView extends Backbone.View
    initialize: (option) ->
      @dashboard = option.dashboard
      @achivements = option.achivements
      $.ajax
        type: "GET",
        url:"https://core.unitus-ac.com/Achivements",
        success: (data)=>
          console.log data
          $.each data.Content.AchivementCategories, (parentIndex, parentObj)=>
            categoryName = "belonged" + parentObj.CategoryName
            $.each parentObj.Achivements, (index, obj)=>
              if parentIndex == 0
                achivement = new Achivement(Name: obj.AchivementName, AwardedDate: obj.AwardedDate, BadgeImageUrl: obj.BadgeImageUrl, CurrentProgress: (if obj.CurrentProgress == "NaN" then null else obj.CurrentProgress.toFixed(2)), IsAwarded: obj.IsAwarded, ProgressDiff: (if obj.ProgressDiff == "NaN" then null else obj.ProgressDiff.toFixed(2)) )
                achivement.set @hash(categoryName, true)
                @achivements.add achivement
              else
                achivement = @achivements.where(Name: obj.AchivementName)[0]
                achivement.set @hash(categoryName, true)

            @listenTo @achivements, parentObj.CategoryName, =>
              @render @achivements.where(@hash("belonged"+parentObj.CategoryName, true)), parentObj.CategoryName

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
            @achivement.set(Description: values.AchivementDescription, AwardedPerson: values.AwardedPerson, AwardedRate: (if values.AwardedRate == "NaN" then null else values.AwardedRate.toFixed(2)), AcuireRateGraphPoints: values.AcuireRateGraphPoints, AwardedPerson: values.AwardedPerson,  CircleStatistics: values.CircleStatistics, ProgressGraphPoints: values.ProgressGraphPoints, SumPerson: values.SumPerson)
            $(@$el.children("[data-js=achivementPanel]")[0])
            .html AchivementShowTemplate(achivement: @achivement, data: JSON.stringify(@achivement), dashboard: @dashboard)
            .removeClass("hidden_panel_r")
          error: (data)->
            console.log data
      else
        $(@$el.children("[data-js=achivementPanel]")[0])
        .html AchivementShowTemplate(achivement: @achivement)
        .removeClass("hidden_panel_r")

    closePanel: (e)->
      $(@$el.children("[data-js=achivementPanel]")[0]).addClass("hidden_panel_r")

    render: (achivements, categoryName)->
      $(@$el.find("[data-js=categoryName]")).html "（" + categoryName + "）"
      $(@$el.find("[data-js=badges]")).html ''
      $.each achivements, (index, a) =>
        $(@$el.find("[data-js=badges]")).append AchivementListTemplate(achivement: a)

    hash: (key, value) ->
      h = {};
      h[key] = value
      h

