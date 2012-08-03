template = require './templates/block'


class exports.BlockView extends Backbone.View

  initialize: ->
    @template = template
    @model.bind "update", @render, @

  render: ->
    @$el.html @template 
      block: @model.toJSON()
      connectedChannels: @model.connectedChannels()
    @delegateEvents()