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
			channel = new Channel
				slug: block.get('slug')
			app.addChannel(channel)
		else 
			app.addBlock(block)
		false

	render: ->
		@$el.html @template 
			blocks: @model.toJSON()