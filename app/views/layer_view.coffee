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

  render: ->
    @$el.html @template
      layerClass: @layerClass()

    @contentView.render()
    @delegateEvents()
    @$el.append @contentView.el
    @$el.css
      top: @options.depth * 55
      zIndex: @options.depth
      backgroundColor: 'white'

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

