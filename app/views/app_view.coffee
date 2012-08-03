
class exports.AppView extends Backbone.View

  events:
    "click #logo" : "reset"

  reset: ->
    app.router.index()
