define ['jquery', 'backbone', 'templates/dashboard/dashboard', 'views/dashboard/header', 'views/dashboard/panel', 'models/user', 'models/admin_panel'], ($, Backbone, template, HeaderView, PanelView, User, AdminPanel) ->
  class DashboadView extends Backbone.View
    initialize: (option) ->
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


