{LayerView} = require('views/layer_view')


class exports.LayerManager extends Backbone.View

	initialize: ->
		@layers = []

	render: ->
		@$el.html('')
		@layers.forEach (layer)=>
			layer.render()
			@$el.append layer.el 

		if @layers.length > 0
			@setPageSize()

		else
			$('#mainWrapper').css
				height: 'auto'

	addLayer: (contentView)->
		layer = new LayerView
			contentView: contentView
			depth: @layers.length + 1
			manager: @
		contentView.layer = layer

		contentView.model.bind 'loaded', @setPageSize, @
		layer.bind 'layer:close', @removeLayer, @

		@layers.push(layer)
		@render()
		
		$('body').clearQueue().animate
			scrollTop: @layers[@layers.length-1].$el.offset().top
		, 500

	setPageSize: ->
		last = $(@layers[@layers.length - 1].el)
		$(last).imagesLoaded =>
			$('#mainWrapper').css
				height: last.position().top + last.height() 


	removeLayer: (layer)->
		layerIndex = @layers.indexOf layer
		@layers.splice(layerIndex, @layers.length)
		@render()
		app.resetUrl()

	setTop: (layer)->
		layerIndex = @layers.indexOf(layer) + 1
		@layers.splice(layerIndex, @layers.length)
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

		app.resetUrl()

	_layerByName: (name)->
		_.filter @layers, (layer)->  layer.name() is name

	reset: ->
		@layers = []
		@render()