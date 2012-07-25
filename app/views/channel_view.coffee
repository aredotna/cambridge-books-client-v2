template = require './templates/channel'

class exports.ChannelView extends Backbone.View

	events:
		"click .block" : "showBlock"

	initialize: ->
		@template = template
		@model.bind "add", @render, @

	showBlock: (e)->
		block = @model.at(e.target.id)
		false

	render: ->
		@$el.html @template 
			blocks: @model.toJSON()