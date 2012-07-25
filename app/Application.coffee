MainRouter = require('routers/main_router').MainRouter

class exports.Application

	initialize: ->

		@views = {}
		@routers = {}
		@channels = {}

		@rootChannel = "cambridge-book--2"

		@routers.main = new MainRouter()
		Backbone.history.start()


	setView: (view)->
		@contentView = view
		@contentView.render()
		$('#content').html('').append(@contentView.el)



