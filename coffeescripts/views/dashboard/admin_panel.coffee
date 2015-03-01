define ['jquery', 'backbone','templates/dashboard/admin_panel', 'models/circle'], ($, Backbone, AdminTemplate, Circle) ->
  class AdminPanelView extends Backbone.View
    initialize: (option) ->
      @notyHelper = new NotyHelper()
      @circle =  new Circle()
      @watchNewCircleEvents()

      sendData =
        count: 40
      $.ajax
        type: "GET",
        url:"https://core.unitus-ac.com/Person",
        data: sendData,
        success: (msg)->
          $.each msg.Content.Persons, ->
            text =  ''
            text += '<tr>'
            text += '<td class="name name_w">' + this.Name + '<i data-js="deleteAccount" class="fa fa-times"></i></td>'
            text += '<td class="author author_w">' + "閲覧者" + '</td>'
            text += '<td class="number number_w">' + this.Grade + '</td>'
            text += '<td class="university university_w">' + this.BelongedTo + '</td>'
            text += '<td class="mail mail_w">' + this.UserName + '<i class="fa fa-clipboard" data-js="copyMail" data-clipboard-text="' + this.UserName + '"></i></td>'
            text += '</tr>'
            $("[data-js=userList]").append(text);

        error: (msg)->
          console.log msg

      @admin_panel = option.admin_panel
      @admin_panel.on "change:isOpen", =>
        @$el.toggleClass("hidden_panel_l")
      @renderAdminPanel()

    events:
      "click [data-js=close_admin]" : "closePanel"
      "focus #adminNewCircle input"    : "watchChangeValue"
      "focus #adminNewCircle textarea" : "watchChangeValue"
      "click [data-js=createCircle]" : "createCircle"

    createCircle: (e)->
      e.preventDefault()
      e.stopPropagation()
      $(e.target).html "<img src='./img/send.gif'>"
      sendData =
        Name: @circle.get("CircleName")
        Description: @circle.get("CircleDescription")
        MemberCount: @circle.get("MemberCount")
        BelongedSchool: @circle.get("BelongedSchool")
        Notes: @circle.get("Notes")
        Contact: @circle.get("Contact")
        CanInterColledge: true
        ActivityDate: @circle.get("ActivityDate")
        LeaderUserName: @circle.get("LeaderUserName")
      $.ajax
        type: "POST",
        url:"https://core.unitus-ac.com/Circle",
        data: sendData
        success: (msg)=>
          @notyHelper.generate("success", "作成完了", "#{@circle.get("CircleName")}を追加しました。")
          console.log "成功したよ"
          console.log msg
          $(e.target).html "作成する"
        error: (msg)=>
          console.log "失敗したよ"
          console.log msg
          if msg.statusText == "Conflict"
            @notyHelper.generate("error", "作成失敗", "#{@circle.get("CircleName")}はすでに存在します。")
          else
            switch msg.responseText
              when "Name is empty."
                @notyHelper.generate("error", "作成失敗", "団体名が記入されていません。")
                @$("[data-js=CircleName]").addClass "form-danger"
              when "LeaderUserName is empty."
                @notyHelper.generate("error", "作成失敗", "代表者名が記入されていません。")
                @$("[data-js=LeaderUserName]").addClass "form-danger"
              when "BelongedSchool is empty."
                @notyHelper.generate("error", "作成失敗", "所属大学が記入されていません。")
                @$("[data-js=BelongedSchool]").addClass "form-danger"
              else
                @notyHelper.generate("error", "作成失敗", "#{@circle.get("CircleName")}は何らかの理由で作成できませんでした。")
          $(e.target).html "作成する"
    watchChangeValue: (e) =>
      $target = $(e.target)
      $(e.target).on "change", =>
        console.log $target.attr("data-js")
        $target.removeClass "form-danger"
        @circle.trigger $target.attr("data-js")


    watchNewCircleEvents: (e) =>

      @circle.on "CircleName", =>
        @circle.set CircleName: @$("[data-js=CircleName]").val()
        @validationCreateButton()
        console.log @circle.get("CircleName")
      @circle.on "CircleDescription", =>
        @circle.set CircleDescription: @$("[data-js=CircleDescription]").val()
        console.log @circle.get("CircleDescription")
      @circle.on "MemberCount", =>
        @circle.set MemberCount: @$("[data-js=MemberCount]").val()
        console.log @circle.get("MemberCount")
      @circle.on "WebAddress", =>
        @circle.set WebAddress: @$("[data-js=WebAddress]").val()
      @circle.on "BelongedSchool", =>
        @circle.set BelongedSchool: @$("[data-js=BelongedSchool]").val()
        @validationCreateButton()
        console.log @circle.get("BelongedSchool")
      @circle.on "Notes", =>
        @circle.set Notes: @$("[data-js=Notes]").val()
        console.log @circle.get("Notes")
      @circle.on "Contact", =>
        @circle.set Contact: @$("[data-js=Contact]").val()
        console.log @circle.get("Contact")
      @circle.on "CanInterColledge", =>
        if @$("[data-js=CanInterColledge]").is(':checked')
          @circle.set CanInterColledge: true
        else
          @circle.set CanInterColledge: false
        console.log @circle.get("CanInterColledge")
      @circle.on "ActivityDate", =>
        @circle.set ActivityDate: @$("[data-js=ActivityDate]").val()
        console.log @circle.get("ActivityDate")
      @circle.on "LeaderUserName", =>
        @circle.set LeaderUserName: @$("[data-js=LeaderUserName]").val()
        @validationCreateButton()
        console.log @circle.get("LeaderUserName")

    renderAdminPanel: ->
      @$el.html AdminTemplate()

    closePanel: ->
      @admin_panel.set isOpen: false

    validationCreateButton: =>
      if @circle.get("CircleName") != "" && @circle.get("BelongedSchool") != "" && @circle.get("LeaderUserName") != ""
        @$("[data-js=createCircle]").prop("disabled", false)
      else
        @$("[data-js=createCircle]").prop("disabled", true)
