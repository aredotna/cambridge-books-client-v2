{Block} = require 'models/block'

class exports.Channel extends Backbone.Collection

	model: Block

	url: ->
		"http://arena-cedar.herokuapp.com/api/v1/channels/#{@options.slug}.json?callback=?"

	initialize: (items, options)->
		@options = options

	loadBlocks: (depth=0) ->
		@fetch
			success: (channel, blocks)=>
				@reset()
				@add(blocks.blocks)
				@add(blocks.channels)
				if depth
					@each (block)->
						if block.get('block_type') is "Channel" and block.get('published')
							console.log(block.get('slug'))
							@channel = new Channel(null, slug:block.get('slug'))
							@channel.loadBlocks(depth-1)