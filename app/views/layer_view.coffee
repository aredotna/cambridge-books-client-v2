template = require('./templates/layer')

class exports.LayerView extends Backbone.View

	attributes:
		class: "layer"

	events:
		"click .close": "close"

	initialize: ->
		@template = template
		@contentView = @options.contentView

	render: ->
		@$el.html @template()
		@contentView.render()
		@delegateEvents()
		@$el.append @contentView.el
		@$el.css
			top: @options.depth * 55
			zIndex: @options.depth
			backgroundColor: 'white'

	makeTop: ->
		app.layerManager.setTop(this)

	name: ->
		@contentView.model.options.slug

	close: ->
		@$el.remove()
		@trigger('layer:close', @)

	lightness:->
		(@options.depth * 20) % 100

