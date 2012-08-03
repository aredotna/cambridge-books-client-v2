class exports.OverlayView extends Backbone.View

	events:
		"click ": "close"

	initialize: ->

	open: (contentView) ->
		@contentView = contentView
		@render()
		$('body').css 'overflow', 'hidden'
		@$el.show()

	close: ->
		@$el.hide()
		app.resetUrl()
		$('body').css 'overflow', 'auto'

	render: ->
		@contentView.render()
		@$el.find('.content').html('').append @contentView.$el
