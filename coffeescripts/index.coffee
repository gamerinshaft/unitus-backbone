require.config
  paths:
    jquery: '../../bower_components/jquery/dist/jquery'
    underscore: '../../bower_components/underscore/underscore'
    bootstrap: '../../bower_components/bootstrap/dist/js/bootstrap'
    backbone: '../../bower_components/backbone/backbone'
    jade: '../../bower_components/jade/runtime'
    highcharts: '../../bower_components/highcharts/highcharts'
    noty: '../../bower_components/noty/noty'

  shim:
    'bootstrap':
      deps: ["jquery"]
    'highcharts':
      deps: ["jquery"]
    'noty':
      deps: ["jquery"]
require ['jquery', 'bootstrap', 'highcharts', 'noty', 'views/dashboard/dashboard', 'helpers/notyHelper', 'views/renderer/circle'], ($, bootstrap, highcharts, noty, DashboardView, NotyHelper, CircleRenderView) ->
  $ ->
    new DashboardView(el: $('[data-js=app]'))
