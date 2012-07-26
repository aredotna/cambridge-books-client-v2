{MainRouter} = require('routers/main_router')
{LayerManager} = require('views/layer_manager')


class exports.Application

	initialize: ->

		@views = {}
		@routers = {}
		@channels = {}

		@rootChannel = "cambridge-book--2"

		@layerManager = new layerManager
			el: $('#layers')

		@routers.main = new MainRouter()
		Backbone.history.start()


	addChannel: (channel)->
		view = new ChannelView(channel)
		@addLayer(view)

	addBlock: (block)->
		view = new BlockView(block)
		@addLayer(view)

	addLayer: (content)->
		layerView = new LayerView
			content: content
		@layerManager.addLayer(layerView)

	setView: (view)->
		@contentView = view
		@contentView.render()
		$('#content').html('').append(@contentView.el)



