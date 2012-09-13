
class exports.Block extends Backbone.Model

  url: ->
    "http://are.na/api/v1/blocks/#{@id}.json?callback=?"

  initialize: ->
    if not @get 'block_type'
      @fetch
        success: =>
          @trigger 'loaded'
    @_setArrangementPosition()

  connectedChannels: ->
    _.filter @get('connections'), (connection)=>
      @collection.attributes['slug'] != connection.channel.slug &&
      connection.channel.published == true && 
      _.include app.adminIds, connection.user_id

  _setArrangementPosition: ->
    @set({position: @_channelConnection().position}) if @_isinArrangement()

  _channelConnection: =>
    _.find @get('connections'), (connection) => connection.channel_id is @collection.attributes.id

  _isinArrangement: ->
    if @_channelConnection()?.connection_type is 'Arrangement'
      @set({arrangement: true})
      return true
    else
      @set({arrangement: false})
      return false
