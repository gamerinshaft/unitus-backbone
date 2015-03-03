define ['jquery', 'backbone', 'models/profile'], ($, Backbone, Profile) ->
  class Profiles extends Backbone.Collection
    model: Profile