define ['jquery', 'backbone','templates/dashboard/user_panel', 'templates/dashboard/user_profile', 'views/dashboard/achivement', 'models/circle'], ($, Backbone, UserTemplate, UserProfile, AchivementView, Circle) ->
  class UserPanelView extends Backbone.View
    initialize: (option) ->
      @dashboard = option.dashboard
      @circles = option.circles
      console.log @dashboard
      @belongingCircles = @dashboard.get("CircleBelonging")
      @notyHelper = new NotyHelper()
      @renderUserPanel()
      @renderUserProfile()
      @renderCircleList()
      new AchivementView(el: '[data-js=achivementList]', dashboard: @dashboard)

      if @belongingCircles.length > 0
        @renderBelongingCircles()

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
            circle = new Circle(CircleID: obj.CircleId, CircleName: obj.CircleName, MemberCount: obj.MemberCount, BelongedSchool: obj.BelongedSchool, LastUpdateDate: obj.LastUpdateDate, IsBelonging: obj.IsBelonging)
            @circles.add circle
        error: (msg)->
          console.log msg
     # プロフィール
    renderUserProfile: ->
      @$('[data-js="myProfile"]').html UserProfile(dashboard: @dashboard)

     # 所属団体
    renderBelongingCircles: =>
      $.each @belongingCircles, (index, obj)=>
        circle = new Circle(CircleID: obj.CircleId, CircleName: obj.CircleName, HasAuthority: true, CircleTags: obj.CircleTags)
        @circles.add circle


      textSidebar  = ''
      textPanel    = ''
      textSidebar += '<li class="divider"><h1>所属サークル</h1></li>'
      $.each @belongingCircles, ->
        textSidebar += '<li role="presentation" data-commonId="' + this.CircleId + '">'
        textSidebar += '<a href="#' + this.CircleId + '" aria-controls="#' + this.CircleId + '" role="tab" data-toggle="tab">'
        textSidebar += '<i class="circleIcon">' + this.CircleName.slice(0,1) + '</i>'
        textSidebar += '<span class="title">' + this.CircleName + '</span>'
        textSidebar += '</a>'
        textSidebar += '</li>'
        textPanel   += '<div id="' + this.CircleId + '" class="tab-pane fade in" role="tabpanel" data-commonId="' + this.CircleId + '">'
        textPanel   += '<h1>' + this.CircleName + '</h1>'
        textPanel   += '</div>'
      $("[data-js=userSideList]").append textSidebar
      $("[data-js=userPanelList]").append textPanel

    deleteCircle: (e)=>
      e.preventDefault()
      e.stopPropagation()
      $circleRow = $($($(e.target).get(0)).closest("tr").get(0))
      if confirm $($circleRow.children("td.name").get(0)).text() + "を削除しますか？"
        sendData =
          circleID: $circleRow.attr("data-circleId")
        $.ajax
          type: "DELETE",
          url:"https://core.unitus-ac.com/Circle",
          data: sendData,
          success: (msg)=>
            @notyHelper.generate('info', '削除成功', "サークルを削除しました。")
            target = "[data-commonId=" + $circleRow.attr("data-circleId") + "]"
            $(target).remove()
          error: (msg)=>
            @notyHelper.generate('error', '削除失敗', "何らかの理由でサークルを削除できませんでした。")
