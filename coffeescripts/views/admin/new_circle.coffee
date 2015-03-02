define ['jquery', 'backbone', 'templates/admin/new_circle', 'models/circle'], ($, Backbone, NewCircleTemplate, Circle) ->
  class AdminNewCircleView extends Backbone.View
    initialize: (option) ->
      @circles = option.circles
      @dashboard = option.dashboard
      @notyHelper = new NotyHelper()
      @circle =  new Circle()
      @render()
      @watchNewCircleEvents()

      $.ajax
        type: "GET"
        url:  "https://core.unitus-ac.com/Candidate/University"
        success: (msg)=>
          $.each msg.Content, (index, obj)=>
            @$("[data-js=circleSelect]").append "<option>#{obj}</option>"
          @$("[data-js=circleSelect]").append "<option>その他</option>"
        error: (msg)=>
          console.log msg
    events:
      "change input"    : "watchChangeValue"
      "change textarea" : "watchChangeValue"
      "change select" : "watchChangeValue"
      "click [data-js=createCircle]" : "createCircle"

    render: ->
      @$el.html NewCircleTemplate()

    createCircle: (e)=>
      e.preventDefault()
      e.stopPropagation()
      $(e.target).html "<img src='./img/send.gif'>"
      if @circle.get("LeaderUserName") == @dashboard.get("UserName")
        @circle.set IsBelonging: true
      sendData =
        Name: @circle.get("CircleName")
        Description: @circle.get("CircleDescription")
        MemberCount: @circle.get("MemberCount")
        BelongedSchool: @circle.get("BelongedSchool")
        Notes: @circle.get("Notes")
        Contact: @circle.get("Contact")
        CanInterColledge: @circle.get("CanInterColledge")
        ActivityDate: @circle.get("ActivityDate")
        LeaderUserName: @circle.get("LeaderUserName")
      $.ajax
        type: "POST",
        url:"https://core.unitus-ac.com/Circle",
        data: sendData
        success: (msg)=>
          @notyHelper.generate("success", "作成完了", "#{@circle.get("CircleName")}を追加しました。")
          console.log "成功したよ"

          @circle.set CircleID: msg.Content.CircleId
          @circle.set LastUpdateDate: msg.Content.LastUpdate
          @circle.set MemberCount: msg.Content.MemberCount
          @circles.add @circle
          $(e.target).html "作成する"
        error: (msg)=>
          console.log msg
          if msg.statusText == "Conflict"
            @notyHelper.generate("error", "作成失敗", "#{@circle.get("CircleName")}はすでに存在します。")
          else if msg.statusText == "Not Found"
            @notyHelper.generate("error", "作成失敗", "代表者のメールアドレス(#{@circle.get("LeaderUserName")})はデータベースに存在しません。")
            @$("[data-js=LeaderUserName]").addClass "form-danger"
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
      console.log $target.attr("data-js")
      $target.removeClass "form-danger"
      @circle.trigger $target.attr("data-js")


    watchNewCircleEvents: (e) =>
      @circle.on "CircleName", =>
        @circle.set CircleName: @$("[data-js=CircleName]").val()
        if @isCircleExist()
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
      @circle.on "circleSelect", =>
        value = @$("[data-js=circleSelect]").val()
        if value == "その他"
          @$("[data-js=formWrap]").addClass "open"
          @circle.set BelongedSchool: ""
        else
          @$("[data-js=formWrap]").removeClass "open"
          $("[data-js=BelongedSchool]").val("")
          if value == "-"
            @circle.set BelongedSchool: ""
          else
            @circle.set BelongedSchool: value
        if @isCircleExist()
          @validationCreateButton()
        console.log @circle.get("BelongedSchool")
      @circle.on "BelongedSchool", =>
        @circle.set BelongedSchool: @$("[data-js=BelongedSchool]").val()
        if @isCircleExist()
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
      if @circle.get("CircleName") != "" && @circle.get("LeaderUserName") != "" && @circle.get("BelongedSchool") != ""
        @$("[data-js=createCircle]").prop("disabled", false)
      else
        @$("[data-js=createCircle]").prop("disabled", true)

    isCircleExist: =>
      console.log "isCircles"
      sendData =
        circleName: "#{@circle.get("CircleName")}"
        belongedSchool: "#{@circle.get("BelongedSchool")}"
      $.ajax
        type: "GET",
        url:"https://core.unitus-ac.com/Circle/CheckExist",
        dataType: "text"
        data: sendData
        success: (msg)=>
          false
        error: (msg)=>
          if msg.statusText == "Conflict"
            @notyHelper.generate("error", "作成失敗", "既にそのサークルはデータベースに存在しています")
          else
            @notyHelper.generate("error", "作成失敗", "データチェックに失敗しました")
          true

