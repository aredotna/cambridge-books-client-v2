class exports.OverlayView extends Backbone.View

  events:
    "click ": "close"

  initialize: ->

  open: (contentView) ->
    @contentView = contentView
    @render()
    $('body').css 'overflow', 'hidden'
    @$el.css('background-color', @get_random_color())
    @$el.show()

  close: ->
    @$el.hide()
    app.resetUrl()
    $('body').css 'overflow', 'auto'

  render: ->
    @contentView.render()
    @$el.find('.content').html('').append @contentView.$el

  rand: (min, max)->
    parseInt(Math.random() * (max-min+1), 10) + min

  get_random_color: ()->
    h = @rand(1, 360);
    s = @rand(0, 100)
    l = @rand(0, 50)
    'hsl(' + h + ',' + s + '%, '+0+'%)'

