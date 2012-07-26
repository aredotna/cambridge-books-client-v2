class exports.LayerView extends Backbone.View

	attributes:
		class: "layer"

	events:
		"click .close": "close"

	initialize: ->
		@contentView = @options.contentView

	render: ->
		@$el.html @contentView.render()
		@$el.css
			top: @options.depth * 50
			zIndex: @options.depth
			backgroundColor: "hsl(250, 100%, "+(@options.depth*20+30)+"%)"

	close: ->