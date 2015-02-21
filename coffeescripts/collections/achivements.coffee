define ['jquery', 'backbone', 'models/achivement'], ($, Backbone, Achivement) ->
  class Achivements extends Backbone.Collection
    model: Achivement