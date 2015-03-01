define ['jquery', 'backbone', 'templates/dashboard/dashboard', 'views/dashboard/header', 'views/dashboard/panel', 'models/user', 'models/admin_panel'], ($, Backbone, template, HeaderView, PanelView, User, AdminPanel) ->
  class DashboadView extends Backbone.View
    initialize: (option) ->
      @generate('error', "通信失敗", "不正な値が入力されました")
      @user = new User()
      $.ajaxSetup
        xhrFields:
          withCredentials: true
        dataType: 'json'
        data:
          ValidationToken: 'abc'

      $.ajax
        url: 'https://core.unitus-ac.com/Dashboard'
        type: 'GET'

        success: (msg) =>
          console.log msg
          $("[data-js=loading]").fadeOut()
          data = msg.Content
          @user.set name: data.Name
          @user.set mail: data.UserName
          @user.set avatar: data.AvatarUri
          @user.set isAdmin: data.IsAdministrator
          @user.set circles: data.CircleBelonging

          if @user.get("isAdmin")
            @admin_panel = new AdminPanel()

          @renderDashboard();
          new HeaderView(el: $("[data-js=header]"), user: @user, admin_panel:  @admin_panel)
          new PanelView(el: $("[data-js=panel]"), user: @user, admin_panel: @admin_panel)
          @$el.fadeIn()
        error: (XMLHttpRequest, textStatus) ->
          console.log XMLHttpRequest
          console.log textStatus
          if textStatus == "error" || XMLHttpRequest.ErrorMessage == "Unauthorized API Access"
             location.assign "https://core.unitus-ac.com/Account/Login"
    renderDashboard: ->
      @$el.html template(user: @user)

    generate: (type, title, content) ->
      icon = ''
      if type == 'error'
        icon = 'fa-bolt'
      else if type == 'success'
        icon = 'fa-thumbs-o-up'
      else if type == 'info'
        icon = 'fa-info'
      text = '<div class="noty_title"><i class="fa ' + icon + '"></i>' + title + '</div><div class="noty_content">' + content + '</div>'
      n = noty(
        text: text
        type: type
        dismissQueue: true
        layout: 'topLeft'
        closeWith: [ 'click' ]
        theme: 'relax'
        maxVisible: 10
        animation:
          open: 'animated fadeInLeft'
          close: 'animated fadeOutLeft'
          easing: 'swing'
          speed: 100)
      setTimeout (->
        $('#' + n.options.id).trigger 'click'
      ), 3000


