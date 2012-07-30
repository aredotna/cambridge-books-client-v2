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
		@$el.html('')
		@layers.forEach (layer)=>
			layer.render() 
			@$el.append(layer.el)

	removeLayer: (layer)->
		@layers.forEach (_layer)=>
			if _layer is layer 
				@layers.splice @layers.indexOf(_layer), 1