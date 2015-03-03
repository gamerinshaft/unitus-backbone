define ['jquery', 'backbone', 'templates/dashboard/dashboard', 'views/dashboard/header', 'views/dashboard/panel', 'models/admin_panel', 'models/profile', 'collections/profiles'], ($, Backbone, template, HeaderView, PanelView, AdminPanel, Profile, Profiles) ->
  class DashboadView extends Backbone.View
    initialize: (option) ->
      @dashboard = option.dashboard
      @profile = new Profile()
      @profiles = new Profiles()
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
          $("[data-js=loading]").fadeOut()
          data = msg.Content
          @dashboard.set Name: data.Name
          @dashboard.set AchivementCategories: data.AchivementCategories
          @dashboard.set UserName: data.UserName
          @dashboard.set AvatarUri: data.AvatarUri
          @dashboard.set IsAdministrator: data.IsAdministrator
          @dashboard.set CircleBelonging: data.CircleBelonging
          @dashboard.set GithubAssociation: data.Profile.GithubProfile.AssociationEnabled
          profile = data.Profile
          @profile.set BelongedSchool: profile.BelongedSchool, CreatedDateInfo: profile.CreatedDateInfo, CreatedDateInfoByDateOffset: profile.CreatedDateInfoByDateOffset, CurrentGrade: profile.CurrentGrade, Email: profile.Email, Faculty: profile.Faculty, GithubProfile: profile.GithubProfile, Major: profile.Major, Notes: profile.Notes, Url: profile.Url, IsSelf: true
          @profiles.add @profile

          if @dashboard.get("IsAdministrator")
            @admin_panel = new AdminPanel()

          @renderDashboard();
          new HeaderView(el: $("[data-js=header]"), dashboard: @dashboard, admin_panel:  @admin_panel)
          new PanelView(el: $("[data-js=panel]"), dashboard: @dashboard, admin_panel: @admin_panel, circles: @circles)
          @$el.fadeIn()
        error: (XMLHttpRequest, textStatus) ->
          if textStatus == "error" || XMLHttpRequest.ErrorMessage == "Unauthorized API Access"
             location.assign "https://core.unitus-ac.com/Account/Login"
    renderDashboard: ->
      @$el.html template(dashboard: @Dashboard)

