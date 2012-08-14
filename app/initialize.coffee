###
 * Application Initializer
 * 
 * @langversion CoffeeScript
 * 
 * @author 
 * @since  
 ###

{Application} = require('Application')

$ ->

	window.app = new Application
	window.app.initialize
		rootChannel : "cambridge-book--2"
		baseChannel : "cb-about-test"
	
