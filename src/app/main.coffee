window.app = {}
app.routers = {}
app.models = {}
app.collections = {}
app.views = {}

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



$(document).ready ->
	window.app = new exports.Application
	window.app.initialize()