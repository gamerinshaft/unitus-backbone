define ['jquery', 'backbone','templates/dashboard/user_panel', 'views/dashboard/achivement', 'models/circle', 'views/dashboard/profilebar'], ($, Backbone, UserTemplate, AchivementView, Circle, ProfilebarView) ->
  class UserPanelView extends Backbone.View
    initialize: (option) ->
      @dashboard = option.dashboard
      @circles = option.circles
      @belongingCircles = @dashboard.get("CircleBelonging")
      @notyHelper = new NotyHelper()
      @renderUserPanel()
      new ProfilebarView(el: '[data-js="myProfile"]', dashboard: @dashboard)
      @renderCircleList()
      new AchivementView(el: '[data-js=achivementList]', dashboard: @dashboard)

    events:
      "click [data-js=deleteCircle]" : "deleteCircle"

    renderUserPanel: ->
      @$el.html UserTemplate()

     # サークル一覧
    renderCircleList:=>
      circleList = []
      dashboard = @dashboard
      sendData =
        count: 40
        offset: 0
      $.ajax
        type: "GET",
        url:"https://core.unitus-ac.com/Circle",
        data: sendData,
        success: (msg)=>
          $.each msg.Content.Circle, (index, obj)=>
            existCircle = @circles.where(CircleID: obj.CircleId)
            if existCircle.length <= 0
              circle = new Circle(CircleID: obj.CircleId, CircleName: obj.CircleName, MemberCount: obj.MemberCount, BelongedSchool: obj.BelongedSchool, LastUpdateDate: obj.LastUpdateDate, IsBelonging: obj.IsBelonging)
              @circles.add circle
            else
              console.log "これです。"
              existCircle[0].set CircleID: obj.CircleId, CircleName: obj.CircleName, MemberCount: obj.MemberCount, BelongedSchool: obj.BelongedSchool, LastUpdateDate: obj.LastUpdateDate, IsBelonging: obj.IsBelonging
        error: (msg)->
          console.log msg

    deleteCircle: (e)=>
      e.preventDefault()
      e.stopPropagation()
      $circleRow = $($($(e.target).get(0)).closest("tr").get(0))
      if confirm $($circleRow.children("td.name").get(0)).text() + "を削除しますか？"
        id = $circleRow.attr("data-circleListID")
        sendData =
          circleID: id
        $.ajax
          type: "DELETE",
          url:"https://core.unitus-ac.com/Circle",
          data: sendData,
          success: (msg)=>
            @notyHelper.generate('info', '削除成功', "サークルを削除しました。")
            target = "[data-commonId=" + id + "]"
            console.log target
            $(target).remove()
          error: (msg)=>
            @notyHelper.generate('error', '削除失敗', "何らかの理由でサークルを削除できませんでした。")
