{LayerView} = require('views/layer_view')

class exports.LayerManager extends Backbone.View

	initialize: ->
		@layers = []

	addLayer: (contentView)->
		layer = new LayerView
			contentView: contentView
			depth: @layers.length

		@layers.push(layer)
		@render()

	render: ->
		for i in [0..@layers.length-1]
			@layers[i].render() 
			@layers[i].$el.appendTo(@$el)