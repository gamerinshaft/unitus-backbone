define ['jquery', 'backbone'], ($, Backbone) ->
  class AdminPanel extends Backbone.Model
    defaults:
      isOpen: false
