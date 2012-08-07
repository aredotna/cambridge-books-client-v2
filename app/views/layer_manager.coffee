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
		@render()
		
		$('body').clearQueue().animate
			scrollTop: @layers[@layers.length-1].$el.offset().top

	render: ->
		@$el.html('')
		@layers.forEach (layer)=>
			layer.render() 
			@$el.append(layer.el)

	removeLayer: (layer)->
		layerIndex = @layers.indexOf layer
		@layers.splice(layerIndex, @layers.length)
		@render()
		app.resetUrl()

	setTop: (layer)->
		layerIndex = @layers.indexOf layer + 1
		@layers.splice(layerIndex - 1, @layers.length)
		@render()
		app.resetUrl()

	currentPath: ->
		slugs = @layers.map (layer)=>
			layer.name()
		slugs.join('/')

	reset: ->
		@layers = []