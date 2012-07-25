template = require 'views/templates/channel'
{Block} = require 'models/block'

class exports.ChannelView extends Backbone.View

	events:
		"click .block" : "showBlock"

	initialize: ->
		@template = template
		@model.bind "add", @render, @

	showBlock: ->

	render: ->
		console.log @model.toJSON()
		@$el.html @template 
			blocks: @model.toJSON()