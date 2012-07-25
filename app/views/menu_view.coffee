template = require('views/templates/menu')


class exports.MenuView extends Backbone.View

	defaults: 
		depth: 1

	initialize: ->

		_.extend(@options, defaults)
		@template = template

		if @model.options.depth < @options.depth
			@model.loadBlocks(depth)

	render: ->
		@$el.html @template
			blocks: @model.toJSON()



