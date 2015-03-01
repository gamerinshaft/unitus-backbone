define ['jquery', 'backbone','templates/dashboard/admin_panel', 'models/circle'], ($, Backbone, AdminTemplate, Circle) ->
  class AdminPanelView extends Backbone.View
    initialize: (option) ->
      @circle =  new Circle()
      @debug2()
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
      "focus #adminNewCircle input"    : "debug"
      "focus #adminNewCircle textarea" : "debug"
      "click [data-js=createCircle]" : "createCircle"

    createCircle: (e)->
      e.preventDefault()
      e.stopPropagation()
      $(e.target).html "<img src='./img/send.gif'>"
      console.log "create!"
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
          console.log "成功したよ"
          console.log msg
          $(e.target).html "作成する"
        error: (msg)=>
          console.log "失敗したよ"
          console.log msg
          $(e.target).html "作成する"
    debug: (e) =>
      console.log "あなたのこゝろにロックオン!"
      target = $(e.target).attr("data-js")
      $(e.target).on "change", =>
        console.log target
        @circle.trigger target

    debug2: (e) =>
      @circle.on "CircleName", =>
        @circle.set CircleName: @$("[data-js=CircleName]").val()
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
        console.log @circle.get("LeaderUserName")

    renderAdminPanel: ->
      @$el.html AdminTemplate()

    closePanel: ->
      @admin_panel.set isOpen: false
