{LayerView} = require('views/layer_view')

class exports.LayerManager extends Backbone.View

	initialize: ->
		@layers = []

	addLayer: (contentView)->
		layer = new LayerView
			contentView: contentView
			depth: @layers.length

		@bind 'layer:close', @removeLayer, @

		@layers.push(layer)
		@render()

	render: ->
		@$el.html()
		for i in [0..@layers.length-1]
			@layers[i].render() 
			@$el.append(@layers[i].el)

	removeLayer: (layer)->

