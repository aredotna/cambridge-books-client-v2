template = require './templates/channel'


class exports.ChannelView extends Backbone.View

  events:
    "click .block"  : "showBlock"
    "click .title"  : "makeTop"

  initialize: ->
    @template = template
    @model.bind "add", @render, @

  showBlock: (e)->
    id = parseInt(e.target.id)
    block = @model.where(id:id)[0]

    if block.get('block_type') is "Channel"
      app.openChannel(block.get('slug'))
    else 
      app.openBlock(block)
    false

  makeTop: ->
    @layer.makeTop()

  render: ->
    data = @model.toJSON()
    @$el.html @template
      blocks: data.blocks
      title: data.title
      type: @type()
    @delegateEvents()

  type: ->
    type="content"
    @model.each (block) ->
      if block.get('block_type') is "Channel"
        type = "menu"
    type

