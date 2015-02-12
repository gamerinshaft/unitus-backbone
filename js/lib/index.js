require.config({
  paths: {
    jquery: '../../bower_components/jquery/dist/jquery',
    underscore: '../../bower_components/underscore/underscore',
    backbone: '../../bower_components/backbone/backbone',
    jade: '../../bower_components/jade/runtime'
  }
});

require(['jquery', 'views/dashboard/dashboard'], function($, DashboardView) {
  return $(function() {
    console.log("jpge");
    return new DashboardView({
      el: $('[data-js=app]')
    });
  });
});
