template = require './templates/channel'


class exports.ChannelView extends Backbone.View

  events:
    "click .block" : "showBlock"

  initialize: ->
    @template = template
    @model.bind "add", @render, @

  showBlock: (e)->
    id = parseInt(e.target.id)
    block = @model.where(id:id)[0]

    if block.get('block_type') is "Channel"
      app.addChannel(block.get('slug'))
    else 
      app.addBlock(block.id)
    false

  render: ->
    @$el.html @template 
      blocks: @model.toJSON()
    @delegateEvents()

