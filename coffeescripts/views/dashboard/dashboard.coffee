define ['jquery', 'backbone', 'templates/dashboard/dashboard', 'views/dashboard/header', 'views/dashboard/panel', 'models/user', 'models/admin_panel'], ($, Backbone, template, HeaderView, PanelView, User, AdminPanel) ->
  class DashboadView extends Backbone.View
    initialize: (option) ->
      @user = new User()
      $.ajax
        url: 'https://core.unitus-ac.com/Dashboard/Dummy'
        data:
          validationToken: 'abc'
        type: 'GET'

        success: (msg) =>
          console.log msg.Content
          data = msg.Content
          @user.set name: data.Name
          @user.set mail: data.UserName
          @user.set avatar: data.AvatarUri
          @user.set isAdmin: data.IsAdministrator

          if @user.get("isAdmin")
            @admin_panel = new AdminPanel()

          @renderDashboard();
          new HeaderView(el: $("[data-js=header]"), user: @user, admin_panel:  @admin_panel)
          new PanelView(el: $("[data-js=panel]"), user: @user, admin_panel: @admin_panel)

        error: (msg) ->
          console.log msg

    renderDashboard: ->
      @$el.html template(user: @user)
