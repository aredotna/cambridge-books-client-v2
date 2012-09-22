{MainRouter} = require('routers/main_router')
{Channel} = require('models/channel')
{Block} = require('models/block')
{LayerManager} = require('views/layer_manager')
{LayerView} = require('views/layer_view')
{ChannelView} = require('views/channel_view')
{BlockView} = require('views/block_view')
{AppView} = require('views/app_view')
{BaseView} = require('views/base_view')
{NavView} = require('views/nav_view')

class exports.Application

  defaults: {}
  
  adminIds: [228, 235, 729] 

  initialize: (options)->
    @options = {}
    _.extend(@options, options)
    @layerManager = new LayerManager el: $('#layers')
    @router = new MainRouter()
    @appView = new AppView el: $('body')
    @navViw = new NavView model: new Channel(null, slug: @options.rootChannel), el: $('#mainNav')
    @baseView = new BaseView model: new Channel(null, slug: @options.baseChannel), el: $('#base')
    Backbone.history.start()

  openChannel: (slug)->
    @addChannel(slug)
    @router.trackPageview(slug)
    @resetUrl()

  addChannel: (slug)->
    channel = new Channel null,
      slug: slug

    view = new ChannelView(model:channel)
    @layerManager.addLayer(view)
    channel

  addBlock: (id)->
    block = new Block id: id
    view = new BlockView model: block
    view.$el.addClass('channelView')
    @layerManager.addLayer(view)
    block

  resetUrl: ->
    @router.navigate @layerManager.toPath()

  reset: ->
    @layerManager.reset()
