define ['jquery', 'backbone', 'templates/dashboard/header', 'templates/header/config'], ($, Backbone, HeaderTemplate, ConfigTemplate) ->
  class HeaderView extends Backbone.View
    initialize: (option) ->
      @dashboard = option.dashboard
      @admin_panel = option.admin_panel
      @notyHelper = new NotyHelper()
      @renderTemplate()
      @renderConfig()
      unless @dashboard.get("GithubAssociation")
        @settingModalOpen()

    events:
      "click [data-js=adminToggle]" : "adminOpen"
      "click [data-js=setting]" : "settingModalOpen"
      "click [data-js=authorizeGithub]" : "authorizeGithub"

    renderTemplate: ->
      @$el.html HeaderTemplate(dashboard: @dashboard)

    settingModalOpen: (e)->
      $("[data-js=settingModal]").modal("show")


    adminOpen: (e)->
      e.preventDefault()
      e.stopPropagation()
      @admin_panel.set isOpen: true

    authorizeGithub: ->
      location.assign 'https://core.unitus-ac.com/Github/Authorize'

    renderConfig: =>
      $.ajax
        type: "GET"
        url:  "https://core.unitus-ac.com/Config"
        success: (msg)=>
          $.each msg.Content.DisclosureConfigs, (index, obj) =>
            @renderConfigTemplate(obj)
            $("[data-property=#{obj.Property}] input").on "change", (e) =>
              sendData =
                ConfigString: $(e.target).attr("id")
                Property: obj.Property
              $.ajax
                type: "PUT"
                url:  "https://core.unitus-ac.com/Config/Disclosure"
                data: sendData
                success: (msg) =>
                  @notyHelper.generate 'success', '範囲変更', '公開範囲を変更しました。'
                error: (msg) =>
                  @notyHelper.generate 'error', '変更失敗', '公開範囲を変更できませんでした。'
        error: (msg)=>
          @notyHelper.generate 'error', '取得失敗', '範囲設定項目を取得できませんでした。'

    renderConfigTemplate: (config)->
      @$("[data-js=DisclosureList]").append ConfigTemplate(config: config)


