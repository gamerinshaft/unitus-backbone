define ['jquery', 'backbone', 'models/circle'], ($, Backbone, Circle) ->
  class Circles extends Backbone.Collection
    model: Circle