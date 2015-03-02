define ['jquery', 'backbone'], ($, Backbone) ->
  class CircleRenderView extends Backbone.View
    initialize: (option)->
      @circles = option.circles
      @listenTo @circles, 'add', (circle)->
        console.log "ついかされましたたたたたたt"

    renderAll: ->
      console.log "全てをレンダーするぜ"

    renderCircleList: (circle, user)->
      text =  ''
      text += '<tr data-circleID="' +circle.get("CircleId") + '" data-commonId="' + circle.get("CircleId") + '">'
      text += '<td class="name name_w">' + circle.get("CircleName") + '<i class="glyphicon glyphicon-eye-open"></i></td>'
      text += '<td class="author author_w">' + "閲覧者" + '</td>'
      text += '<td class="number number_w">' + circle.get("MemberCount") + '</td>'
      text += '<td class="university university_w">' + circle.get("BelongedSchool") + '</td>'
      if user.get("isAdmin")
        text += '<td class="update update_w">' + circle.get("LastUpdateDate") + '<i class="fa fa-times-circle" data-js="deleteCircle"></i></td>'
      else
        text += '<td class="update update_w">' + circle.get("LastUpdateDate") + '</td>'
      text += '</tr>'
      $("[data-js=circleList]").append(text);

    renderBelongingCircleSidebar: ->
      textSidebar  = ''
      textPanel    = ''
      textSidebar += '<li class="divider"><h1>所属サークル</h1></li>'
      $.each @belongingCircles, ->
        textSidebar += '<li role="presentation" data-commonId="' + this.CircleId + '">'
        textSidebar += '<a href="#' + this.CircleId + '" aria-controls="#' + this.CircleId + '" role="tab" data-toggle="tab">'
        textSidebar += '<i class="circleIcon">' + this.CircleName.slice(0,1) + '</i>'
        textSidebar += '<span class="title">' + this.CircleName + '</span>'
        textSidebar += '</a>'
        textSidebar += '</li>'
        textPanel   += '<div id="' + this.CircleId + '" class="tab-pane fade in" role="tabpanel" data-commonId="' + this.CircleId + '">'
        textPanel   += '<h1>' + this.CircleName + '</h1>'
        textPanel   += '</div>'
      $("[data-js=userSideList]").append textSidebar
      $("[data-js=userPanelList]").append textPanel