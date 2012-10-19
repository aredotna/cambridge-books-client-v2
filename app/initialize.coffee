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
		rootChannel : "3423"
		baseChannel : "3733"
	
