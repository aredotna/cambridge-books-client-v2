{MainRouter} = require('routers/main_router')
{LayerManager} = require('views/layer_manager')
{Channel} = require('models/channel')
{Block} = require('models/block')

class exports.Application

	initialize: ->

		@rootChannel = "cambridge-book--2"

		@layerManager = new LayerManager
			el: $('#layers')

		@router = new MainRouter()
		Backbone.history.start()

	addChannel: (slug)->
		channel = new Channel
			slug: slug
		view = new ChannelView(channel)
		@addLayer(view)

	addBlock: (id)->
		block = new Block
			id: id
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



