define ['jquery', 'backbone', 'templates/dashboard/dashboard', 'views/dashboard/header', 'views/dashboard/panel', 'models/admin_panel'], ($, Backbone, template, HeaderView, PanelView, AdminPanel) ->
  class DashboadView extends Backbone.View
    initialize: (option) ->
      @dashboard = option.dashboard
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
          @dashboard.set Name: data.Name
          @dashboard.set UserName: data.UserName
          @dashboard.set AvatarUri: data.AvatarUri
          @dashboard.set IsAdministrator: data.IsAdministrator
          @dashboard.set CircleBelonging: data.CircleBelonging
          @dashboard.set Profile: data.Profile
          @dashboard.set GithubAssociation: data.Profile.GithubProfie.AssociationEnabled

          if @dashboard.get("IsAdministrator")
            @admin_panel = new AdminPanel()

          @renderDashboard();
          new HeaderView(el: $("[data-js=header]"), dashboard: @dashboard, admin_panel:  @admin_panel)
          new PanelView(el: $("[data-js=panel]"), dashboard: @dashboard, admin_panel: @admin_panel, circles: @circles)
          @$el.fadeIn()
        error: (XMLHttpRequest, textStatus) ->
          console.log XMLHttpRequest
          console.log textStatus
          if textStatus == "error" || XMLHttpRequest.ErrorMessage == "Unauthorized API Access"
             location.assign "https://core.unitus-ac.com/Account/Login"
    renderDashboard: ->
      @$el.html template(dashboard: @Dashboard)

