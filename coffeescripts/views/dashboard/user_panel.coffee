define ['jquery', 'backbone','templates/dashboard/user_panel'], ($, Backbone, UserTemplate) ->
  class UserPanelView extends Backbone.View
    initialize: (option) ->
      @renderUserPanel()
      sendData =
        count: 40
        offset: 0
        validationToken: 'abc'
      $.ajax
        type: "GET",
        url:"http://unitus-core.azurewebsites.net/Circle/Dummy",
        data: sendData,
        success: (msg)->
          $.each msg.Content.Circle, ->
            console.log this
            text =  ''
            text += '<tr>'
            text += '<td class="name name_w">' + this.CircleName + '<i class="glyphicon glyphicon-eye-open"></i></td>'
            text += '<td class="author author_w">' + "閲覧者" + '</td>'
            text += '<td class="number number_w">' + this. MemberCount + '</td>'
            text += '<td class="university university_w">' + this.BelongedUniversity + '</td>'
            text += '<td class="update update_w">' + this.LastUpdateDate + '<i class="fa fa-clipboard" data-js="copyMail" data-clipboard-text="' + this.UserName + '"></i></td>'
            text += '</tr>'
            $("[data-js=circleList]").append(text);
        error: (msg)->
          console.log msg


    renderUserPanel: ->
      @$el.html UserTemplate()

