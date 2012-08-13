template = require('./templates/nav')


class exports.NavView extends Backbone.View
  
  initialize: ->
    @template = template
    @render()
    @model.bind 'loaded', @render, @ 

  render: ->
    @$el.html @template
      blocks: @model.bySelection().toJSON().blocks