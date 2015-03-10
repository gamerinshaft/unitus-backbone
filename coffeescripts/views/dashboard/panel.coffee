define ['jquery', 'backbone', 'views/dashboard/user_panel','views/dashboard/admin_panel'], ($, Backbone, UserPanelView, AdminPanelView) ->
  class PanelView extends Backbone.View
    initialize: (option) ->
      @circles = option.circles
      @dashboard = option.dashboard
      @admin_panel = option.admin_panel
      @selfProfile = option.selfProfile
      @renderDashboard();
    renderDashboard: ->
      new UserPanelView(el: $("[data-js=basic]"), dashboard: @dashboard, circles: @circles, selfProfile: @selfProfile)
      if @dashboard.get("IsAdministrator")
        new AdminPanelView(el: $("[data-js=admin]"), admin_panel: @admin_panel, circles: @circles, dashboard: @dashboard)
