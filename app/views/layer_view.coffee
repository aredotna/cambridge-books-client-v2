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
			top: @options.depth * 50
			zIndex: @options.depth
			backgroundColor: "hsl(250, 100%, "+(@options.depth*20+30)+"%)"

	close: ->
		@$el.remove()
		@trigger('layer:close', @)


