{LayerView} = require('views/layer_view')

class exports.LayerManager

	initialize: ->

	addLayer: (contentView)->
		layer = new LayerView
			contentView: contentView
			depth: @layers.length

		@layers.push(layer)
		@render()

	render: ->
		for i in [0..@layers.length]
			@layers[i].render() 
			@layers[i].el.appendTo(@$el)