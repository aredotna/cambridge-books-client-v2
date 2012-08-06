
class exports.Block extends Backbone.Model

	connectedChannels: ->
		_.filter @get('connections'), (connection)=>
			@collection.attributes['slug'] != connection.channel.slug &&
			connection.channel.published == true && 
			_.include app.adminIds, connection.user_id


