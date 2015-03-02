define ['jquery', 'backbone', 'templates/dashboard/dashboard', 'views/dashboard/header', 'views/dashboard/panel', 'models/dashboard', 'models/admin_panel'], ($, Backbone, template, HeaderView, PanelView, Dashboard, AdminPanel) ->
  class DashboadView extends Backbone.View
    initialize: (option) ->
      @Dashboard = new Dashboard()
      @circles = option.circles
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
          @Dashboard.set Name: data.Name
          @Dashboard.set UserName: data.UserName
          @Dashboard.set AvatarUri: data.AvatarUri
          @Dashboard.set IsAdministrator: data.IsAdministrator
          @Dashboard.set CircleBelonging: data.CircleBelonging
          @Dashboard.set Profile: data.Profile

          if @Dashboard.get("IsAdministrator")
            @admin_panel = new AdminPanel()

          @renderDashboard();
          new HeaderView(el: $("[data-js=header]"), dashboard: @Dashboard, admin_panel:  @admin_panel)
          new PanelView(el: $("[data-js=panel]"), dashboard: @Dashboard, admin_panel: @admin_panel, circles: @circles)
          @$el.fadeIn()
        error: (XMLHttpRequest, textStatus) ->
          console.log XMLHttpRequest
          console.log textStatus
          if textStatus == "error" || XMLHttpRequest.ErrorMessage == "Unauthorized API Access"
             location.assign "https://core.unitus-ac.com/Account/Login"
    renderDashboard: ->
      @$el.html template(dashboard: @Dashboard)

