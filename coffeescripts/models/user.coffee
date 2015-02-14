define ['jquery', 'backbone'], ($, Backbone) ->
  class User extends Backbone.Model
    defaults:
      name: 'サンプル太郎'
      mail: 'example.com'
      avatar: 'noImage'
      circles: ''
      isAdmin: true
      valdationToken: 'abc'

