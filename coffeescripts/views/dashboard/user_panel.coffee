define ['jquery', 'backbone','templates/dashboard/user_panel', 'templates/dashboard/user_profile', 'views/dashboard/achivement'], ($, Backbone, UserTemplate, UserProfile, AchivementView) ->
  class UserPanelView extends Backbone.View
    initialize: (option) ->
      @user = option.user
      @belongingCircles = @user.attributes.circles
      @renderUserPanel()
      @renderUserProfile()
      @renderCircleList()
      new AchivementView(el: '[data-js=achivementList]', user: @user)

      if @belongingCircles.length > 0
        @renderBelongingCircles()

    events:
      "click [data-js=deleteCircle]" : "deleteCircle"

    renderUserPanel: ->
      @$el.html UserTemplate()

    renderCircleList: ->
      user = @user
      sendData =
        count: 40
        offset: 0
      $.ajax
        type: "GET",
        url:"https://core.unitus-ac.com/Circle",
        data: sendData,
        success: (msg)->
          console.log msg.Content.Circle
          $.each msg.Content.Circle, ->
            text =  ''
            text += '<tr data-circleID="' +this.CircleId + '" data-commonId="' + this.CircleId + '">'
            text += '<td class="name name_w">' + this.CircleName + '<i class="glyphicon glyphicon-eye-open"></i></td>'
            text += '<td class="author author_w">' + "閲覧者" + '</td>'
            text += '<td class="number number_w">' + this. MemberCount + '</td>'
            text += '<td class="university university_w">' + this.BelongedUniversity + '</td>'
            if user.get("isAdmin")
              text += '<td class="update update_w">' + this.LastUpdateDate + '<i class="fa fa-times-circle" data-js="deleteCircle"></i></td>'
            else
              text += '<td class="update update_w">' + this.LastUpdateDate + '</td>'
            text += '</tr>'
            $("[data-js=circleList]").append(text);
        error: (msg)->
          console.log msg

    renderUserProfile: ->
      @$('[data-js="myProfile"]').html UserProfile(user: @user)

    renderBelongingCircles: ->
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

    deleteCircle: (e)->
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
          success: (msg)->
            target = "[data-commonId=" + $circleRow.attr("data-circleId") + "]"
            $(target).remove()
          error: (msg)->
            console.log "削除できませんでした。"
