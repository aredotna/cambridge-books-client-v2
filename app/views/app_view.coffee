
class exports.AppView extends Backbone.View

  events:
    "click #infoLink" : "reset"

  reset: ->
    app.router.index()
