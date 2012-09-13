template = require('./templates/layer')

class exports.LayerView extends Backbone.View

  attributes:
    class: "layer"

  events:
    "click .close": "close"
    "click .topLink": "makeTop"

  initialize: ->
    @template = template
    @manager = @options.manager
    @contentView = @options.contentView
    @contentView.model.bind 'loaded', @onLoad, @
    @animateLoader(0)

  onLoad: ->
    @stopLoader()
    @render()

  render: ->
    @$el.html @template
      layerClass: @layerClass()
      title: @contentView.title()

    @contentView.render()
    @$('.channelCont').append @contentView.el
    @delegateEvents()
    @$el.css
      top: @options.depth * 55
      zIndex: @options.depth
      backgroundColor: 'white'

  animateLoader: (step)->
    if (step > 3) then step = 0
    html = 'Loading'
    (html += '.') for i in [0..step]
    @$el.find('.title').html(html)
    @loaderTimer = setTimeout =>
      @animateLoader(step + 1)
    , 300

  stopLoader: ->
    clearTimeout(@loaderTimer)
    @render()

  makeTop: ->
    @manager.setTop(this)

  name: ->
    @contentView.name()

  layerClass: ->
    names = @manager.layerNames()
    if names.indexOf @name()
      names.splice(names.indexOf(@name()) + 1, names.length)
      names.join(' ')
    else
      @name()

  close: ->
    @trigger('layer:close', @)

  lightness:->
    (@options.depth * 20) % 100

