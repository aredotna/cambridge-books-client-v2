{LayerView} = require('views/layer_view')


class exports.LayerManager extends Backbone.View

	initialize: ->
		@layers = []

	render: ->
		@$el.html('')
		if @rootLayer
			@rootLayer.render()
			@$el.append @rootLayer.el

			@layers.forEach (layer)=>
				layer.render() 
				@$el.append layer.el 

	setRoot: (contentView)->
		if !@rootLayer
			@rootLayer = new LayerView
				contentView: contentView
				depth: 0
				manager: @
			@rootLayer.bind 'layer:close', @removeLayer, @
			@render()

	addLayer: (contentView)->
		layer = new LayerView
			contentView: contentView
			depth: @layers.length + 1
			manager: @
		contentView.layer = layer

		layer.bind 'layer:close', @removeLayer, @

		@layers.push(layer)
		@render()
		
		$('body').clearQueue().animate
			scrollTop: @layers[@layers.length-1].$el.offset().top

	removeLayer: (layer)->
		if layer is @rootLayer
			@rootLayer = null
			@layers = []
		else
			layerIndex = @layers.indexOf layer
			@layers.splice(layerIndex, @layers.length)
		@render()
		app.resetUrl()

	setTop: (layer)->
		layerIndex = @layers.indexOf layer + 1
		@layers.splice(layerIndex - 1, @layers.length)
		@render()
		app.resetUrl()

	layerNames: ->
		@layers.map (layer)=>
			layer.name()

	toPath: ->
		@layerNames().join('/')

	setFromPath: (path)->

		channelNames = if path then path.split('/') else []
		layerNames = @layers.map (layer)-> layer.name() 

		_.difference(layerNames, channelNames).forEach (layerName)=>
			@removeLayer @_layerByName(layerName)

		_.difference(channelNames, layerNames).forEach (channelName)=>
			app.addChannel(channelName)

	_layerByName: (name)->
		_.filter @layers, (layer)->  layer.name() is name

	reset: ->
		@layers = []