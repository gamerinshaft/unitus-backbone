define ['jquery', 'backbone'], ($, Backbone) ->
  class Dashboard extends Backbone.Model
    defaults:
      name: 'こんにちは'