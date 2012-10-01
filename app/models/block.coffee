
class exports.Block extends Backbone.Model

  url: ->
    "http://api.are.na/v2/blocks/#{@id}.json"

  initialize: ->
    if not @get 'class'
      @fetch
        success: =>
          @trigger 'loaded'

  connectedChannels: ->
    slug = @collection.attributes.slug
    _.filter @get('connections'), (connection)=>
      slug isnt connection.slug and
      connection.published is true and 
      _.include app.adminIds, connection.user_id

  _channelConnection: =>
    _.find @get('connections'), (connection) => 
      connection.channel_id is @collection.attributes.id