{MainRouter} = require('routers/main_router')
{Channel} = require('models/channel')
{Block} = require('models/block')
{LayerManager} = require('views/layer_manager')
{LayerView} = require('views/layer_view')
{ChannelView} = require('views/channel_view')

class exports.Application

  defaults: {}

  initialize: (options)->

    @options = {}
    _.extend(@options, options)
    @layerManager = new LayerManager
    	el: $('#layers')

    @router = new MainRouter()
    Backbone.history.start()

  addChannel: (slug)->
    channel = new Channel null,
      slug: slug
    view = new ChannelView(model:channel)
    @addLayer(view)

  addBlock: (id)->
    block = new Block
      id: id
    view = new BlockView(block)
    @addLayer(view)

  addLayer: (content)->
    @layerManager.addLayer(content)

  setView: (view)->
    @contentView = view
    @contentView.render()
    $('#content').html('').append(@contentView.el)



