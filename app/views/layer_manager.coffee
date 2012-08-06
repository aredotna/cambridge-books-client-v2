{LayerView} = require('views/layer_view')


class exports.LayerManager extends Backbone.View

	initialize: ->
		@layers = []

	addLayer: (contentView)->
		layer = new LayerView
			contentView: contentView
			depth: @layers.length
		contentView.layer = layer

		layer.bind 'layer:close', @removeLayer, @

		@layers.push(layer)
		console.log @layers
		@render()
		
		$('body').clearQueue().animate
			scrollTop: @layers[@layers.length-1].$el.offset().top

	render: ->
		@$el.html('')
		@layers.forEach (layer)=>
			layer.render() 
			@$el.append(layer.el)

	removeLayer: (layer)->
		@layers.forEach (_layer)=>
			if _layer is layer 
				layerIndex = @layers.indexOf(_layer)
				@layers.splice layerIndex, 1
				@setTop(@layers[layerIndex-1])
		app.resetUrl()

	setTop: (layer)->
		topSet = false
		toRemove = []
		@layers.forEach (_layer)=>
			if topSet 
				toRemove.push(_layer)
			if _layer is layer
				topSet = true

		toRemove.forEach (_layer)=>
			_layer.close()

	currentPath: ->
		slugs = @layers.map (layer)=>
			layer.name()
		slugs = slugs.slice(0)
		slugs.shift()
		slugs.join('/')

	reset: ->
		@layers = []