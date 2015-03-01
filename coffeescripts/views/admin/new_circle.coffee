define ['jquery', 'backbone', 'templates/admin/new_circle', 'models/circle'], ($, Backbone, NewCircleTemplate, Circle) ->
  class AdminNewCircleView extends Backbone.View
    initialize: (option) ->
      @notyHelper = new NotyHelper()
      @circle =  new Circle()
      @render()
      @watchNewCircleEvents()

    events:
      "focus input"    : "watchChangeValue"
      "focus textarea" : "watchChangeValue"
      "click [data-js=createCircle]" : "createCircle"

    render: ->
      @$el.html NewCircleTemplate()

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
          else if msg.statusText == "Not Found"
            @notyHelper.generate("error", "作成失敗", "代表者のメールアドレス(#{@circle.get("LeaderUserName")})はデータベースに存在しません。")
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
      console.log "watch 始めました"
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


    validationCreateButton: =>
      if @circle.get("CircleName") != "" && @circle.get("BelongedSchool") != "" && @circle.get("LeaderUserName") != ""
        @$("[data-js=createCircle]").prop("disabled", false)
      else
        @$("[data-js=createCircle]").prop("disabled", true)
