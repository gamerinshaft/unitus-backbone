define ['jquery', 'backbone'], ($, Backbone) ->
  class CircleRenderView extends Backbone.View
    initialize: (option)->
      @circles = option.circles
      @dashboard = option.dashboard
      @listenTo @circles, 'add', (circle)=>
        @renderCircleList(circle, @dashboard)
        console.log circle
        console.log circle.get("IsBelonging")
        @renderBelongingCircleSidebar circle
      @listenTo @circles, 'change', (circle)=>
        console.log circle
        @renderUpdateCircleList(circle, @dashboard)


    renderAll: ->
      console.log "全てをレンダーするぜ"

    renderCircleList: (circle, dashboard)->
      text =  ''
      text += '<tr data-circleListID="' +circle.get("CircleID") + '" data-commonId="' + circle.get("CircleID") + '">'
      text += '<td class="name name_w">' + circle.get("CircleName") + '<i class="glyphicon glyphicon-eye-open"></i></td>'
      text += '<td class="author author_w">' + "閲覧者" + '</td>'
      text += '<td class="number number_w">' + circle.get("MemberCount") + '</td>'
      text += '<td class="university university_w">' + circle.get("BelongedSchool") + '</td>'
      if dashboard.get("IsAdministrator")
        text += '<td class="update update_w">' + circle.get("LastUpdateDate") + '<i class="fa fa-times-circle" data-js="deleteCircle"></i></td>'
      else
        text += '<td class="update update_w">' + circle.get("LastUpdateDate") + '</td>'
      text += '</tr>'
      $("[data-js=circleList]").append(text);

    renderUpdateCircleList: (circle, dashboard)->
      text = ''
      text += '<td class="name name_w">' + circle.get("CircleName") + '<i class="glyphicon glyphicon-eye-open"></i></td>'
      text += '<td class="author author_w">' + "閲覧者" + '</td>'
      text += '<td class="number number_w">' + circle.get("MemberCount") + '</td>'
      text += '<td class="university university_w">' + circle.get("BelongedSchool") + '</td>'
      if dashboard.get("IsAdministrator")
        text += '<td class="update update_w">' + circle.get("LastUpdateDate") + '<i class="fa fa-times-circle" data-js="deleteCircle"></i></td>'
      else
        text += '<td class="update update_w">' + circle.get("LastUpdateDate") + '</td>'

      $("[data-circleListID=#{circle.get("CircleID")}]").html text

    renderBelongingCircleSidebar: (circle)->
      textSidebar = ''
      textPanel = ''
      textSidebar += '<li role="presentation" data-commonId="' + circle.get("CircleID") + '">'
      textSidebar += '<a href="#' + circle.get("CircleID") + '" aria-controls="#' + circle.get("CircleId") + '" role="tab" data-toggle="tab">'
      textSidebar += '<i class="circleIcon">' + circle.get("CircleName").slice(0,1) + '</i>'
      textSidebar += '<span class="title">' + circle.get("CircleName") + '</span>'
      textSidebar += '</a>'
      textSidebar += '</li>'
      textPanel   += '<div id="' + circle.get("CircleID") + '" class="tab-pane fade in" role="tabpanel" data-commonId="' + circle.get("CircleID") + '">'
      textPanel   += '<h1>' + circle.get("CircleName") + '</h1>'
      textPanel   += '</div>'
      $("[data-js=userSideList]").append textSidebar
      $("[data-js=userPanelList]").append textPanel