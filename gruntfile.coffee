module.exports = (grunt) ->

	grunt.initConfig
		pkg: grunt.file.readJSON('package.json')

		connect:
			server:
				options:
					port: 9000
					base: 'deploy/'

		folder: 
			src:	'source/'
			deploy: 'deploy/'
			css:	'source/css/'

		path:
			source:
				coffee:		'<%= folder.src %>'
				css:		'<%= folder.css %>'

			output:
				app:		'<%= folder.deploy %>js/app.js'

			min:
				app:		'<%= folder.deploy %>js/app.min.js'

		banners:
			credits: 	"/**\n * cor media <%= grunt.template.today('yyyy') %>\n * @author: Mark Dooney (Desmarkie) \n **/\n"
			strict:		"'use strict';\n\n"

		 #watch for changes in files
		watch:
			files: [
				'<%= folder.deploy %>index.html'
				'Gruntfile.coffee'
				'<%= path.source.coffee %>*.coffee'
				'<%= path.source.coffee %>**/*.coffee'
				'<%= path.source.css %>*.css'
			]
			tasks: ['onwatch']

		percolator:
			main:
				source: '<%= path.source.coffee %>'
				output: '<%= path.output.app %>'
				main: "App.coffee"
				compile: true
				opts: "--bare"
			app:
				source: '<%= path.source.coffee %>'
				output: '<%= path.output.app %>'
				main: "App.coffee"
				compile: true
				opts: "--bare"

		#uglify javascript
		#read for full options:
		#https://github.com/mishoo/UglifyJS2
		uglify:
			options:
				banner: "<%= banners.credits %>"
				mangle: true
				compress:{
					global_defs: {
						"DEBUG": false
					},
					sequences: true
					properties: false
					dead_code: true
					drop_debugger: true
					unused: true
					warnings: true
				}
			my_target:
				files: [
					'<%= path.min.app %>': ['<%= path.output.app %>']
				]

		cssmin:
			minify:
				src: 'source/css/style.css'
				dest: 'deploy/css/css.min.css'

	grunt.loadNpmTasks 'grunt-contrib-connect'
	grunt.loadNpmTasks 'grunt-contrib-watch'
	grunt.loadNpmTasks 'grunt-coffee-percolator'
	grunt.loadNpmTasks 'grunt-contrib-uglify'
	grunt.loadNpmTasks 'grunt-contrib-cssmin'

	grunt.registerTask 'default', =>
		grunt.task.run ['connect']
		grunt.task.run ['watch']

	grunt.registerTask 'onwatch', [
		'percolator:main'
		'percolator:app'
		'uglify'
		'cssmin'
	]

