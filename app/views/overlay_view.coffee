class exports.OverlayView extends Backbone.View

	events:
		"click ": "close"

	initialize: ->

	open: (contentView) ->
		@contentView = contentView
		@render()
		@$el.show()

	close: ->
		@$el.hide()

	render: ->
		@contentView.render()
		@$el.find('.content').html('').append @contentView.$el
