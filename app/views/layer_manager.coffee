{LayerView} = require('views/layer_view')


class exports.LayerManager extends Backbone.View

	initialize: ->
		@layers = []

	addLayer: (contentView)->
		layer = new LayerView
			contentView: contentView
			depth: @layers.length

		layer.bind 'layer:close', @removeLayer, @

		@layers.push(layer)
		@render()
		
		$('body').animate
			scrollTop: @layers[@layers.length-1].$el.offset().top


	render: ->
		@$el.html()
		for i in [0..@layers.length-1]
			@layers[i].render() 
			@$el.append(@layers[i].el)

	removeLayer: (layer)->
		for _layer in @layers
			if _layer is layer 
				@layers.splice @layers.indexOf(_layer), 1



