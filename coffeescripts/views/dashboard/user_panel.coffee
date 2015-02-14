define ['jquery', 'backbone','templates/dashboard/user_panel', 'templates/dashboard/user_profile'], ($, Backbone, UserTemplate, UserProfile) ->
  class UserPanelView extends Backbone.View
    initialize: (option) ->
      @user = option.user
      @belongingCircles = @user.attributes.circles
      @renderUserPanel()
      @renderUserProfile()
      @renderCircleList()

      if @belongingCircles.length > 0
        @renderBelongingCircles()

    renderUserPanel: ->
      @$el.html UserTemplate()

    renderCircleList: ->
      sendData =
        count: 40
        offset: 0
        validationToken: 'abc'
      $.ajax
        type: "GET",
        url:"https://unitus-core.azurewebsites.net/Circle/Dummy",
        data: sendData,
        success: (msg)->
          $.each msg.Content.Circle, ->
            text =  ''
            text += '<tr>'
            text += '<td class="name name_w">' + this.CircleName + '<i class="glyphicon glyphicon-eye-open"></i></td>'
            text += '<td class="author author_w">' + "閲覧者" + '</td>'
            text += '<td class="number number_w">' + this. MemberCount + '</td>'
            text += '<td class="university university_w">' + this.BelongedUniversity + '</td>'
            text += '<td class="update update_w">' + this.LastUpdateDate + '<i class="fa fa-clipboard" data-js="copyMail" data-clipboard-text="' + this.UserName + '"></i></td>'
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
        textSidebar += '<li role="presentation">'
        textSidebar += '<a href="#' + this.CircleId + '" aria-controls="#' + this.CircleId + '" role="tab" data-toggle="tab">'
        textSidebar += '<i class="circleIcon">' + this.CircleName.slice(0,1) + '</i>'
        textSidebar += '<span class="title">' + this.CircleName + '</span>'
        textSidebar += '</a>'
        textSidebar += '</li>'
        textPanel   += '<div id="' + this.CircleId + '" class="tab-pane fade in" role="tabpanel">'
        textPanel   += '<h1>' + this.CircleName + '</h1>'
        textPanel   += '</div>'
      $("[data-js=userSideList]").append textSidebar
      $("[data-js=userPanelList]").append textPanel