define ['jquery', 'backbone', 'views/dashboard/user_panel','views/dashboard/admin_panel'], ($, Backbone, UserPanelView, AdminPanelView) ->
  class PanelView extends Backbone.View
    initialize: (option) ->
      @circles = option.circles
      @user = option.user
      @admin_panel = option.admin_panel
      @renderDashboard();
    renderDashboard: ->
      new UserPanelView(el: $("[data-js=basic]"), user: @user, circles: @circles)
      if @user.get("isAdmin")
        new AdminPanelView(el: $("[data-js=admin]"), admin_panel: @admin_panel)
