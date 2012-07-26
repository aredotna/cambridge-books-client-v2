class Layer extends Backbone.View

	attributes:
		class: layer

	events:
		"click .close": "close"

	initialize: ->
		@contentView = @options.contentView

	render: ->
		@$el.html @contentView.render()