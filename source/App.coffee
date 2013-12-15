# import renderer.*
# import model.*
class App

	renderer: null
	textures: null

	upPressed: false
	downPressed: false
	leftPressed: false
	rightPressed: false

	topMargin: 0
	leftMargin: 0

	editMode: false

	editStates: ['normal', 'metal', 'corner', 'exit_open', 'jump', 'falling']

	levels: null
	currentLevel: 0

	gameScale: 1

	constructor: ->
		images = [
			{url:'img/pickup_01.png', id:'pickup_01'},
			{url:'img/pickup_02.png', id:'pickup_02'},
			{url:'img/pickup_03.png', id:'pickup_03'},
			{url:'img/pickup_04.png', id:'pickup_04'},
			{url:'img/pickup_05.png', id:'pickup_05'}
			{url:'img/tile-exit-closed.jpg', id:'exit_closed'},
			{url:'img/tile-exit-open.jpg', id:'exit_open'},
			{url:'img/bg.jpg', id:'bg'},
			{url:'img/falling-tile.jpg', id:'falling'},
			{url:'img/metal-tile.jpg', id:'metal'},
			{url:'img/corner-tile.jpg', id:'corner'},
			{url:'img/plain-tile.png', id:'normal'},
			{url:'img/jump-tile.jpg', id:'jump'},
			{url:'img/player.png', id:'player'}
		]
		@textures = new GameTextures(images)
		@textures.load @init

		$('#parse-button').bind 'click', @parseCurrentLevel

	init: =>
		@levels = Levels.Levels
		# @currentLevel = @levels.length-1

		@grid = new GameGrid @levelComplete
		@grid.createGrid @levels[@currentLevel]

		@renderer = new GameRenderer document.getElementById('game-holder')

		window.onresize = @resize
		@resize()

		@renderer.showLevel()

		# @debug = document.createElement 'div'
		# @debug.id = 'debug'
		# document.body.appendChild @debug

		if Modernizr.touch
			@renderer.renderer.view.addEventListener 'touchstart', @handleTouch, false
		else
			window.onkeydown = @handleKeyPress
			window.onkeyup = @handleKeyRelease

		requestAnimationFrame @update
		null

	resize: =>
		if window.innerWidth < 640 or window.innerHeight < 640
			minScale = window.innerWidth/640
			if window.innerHeight/640 < minScale
				minScale = window.innerHeight/640
			@gameScale = minScale
		else
			@gameScale = 1

		$('canvas').css 'width', 640*@gameScale+'px'
		$('canvas').css 'height', 640*@gameScale+'px'
		$('#game-holder').css 'width', 640*@gameScale+'px'
		$('#game-holder').css 'height', 640*@gameScale+'px'
		@leftMargin = ((window.innerWidth - (640*@gameScale))*0.5)
		@topMargin = ((window.innerHeight - (640*@gameScale))*0.5)
		$('#game-holder').css 'left', @leftMargin+'px'
		$('#game-holder').css 'top', @topMargin+'px'
		$('#game-holder').css 'margin-left', 0+'px'
		$('#game-holder').css 'margin-top', 0+'px'

		null

	levelComplete: =>
		@renderer.hideLevel =>
			@currentLevel++
			if @currentLevel == @levels.length then @currentLevel = 0
			@grid.createGrid @levels[@currentLevel]
			@renderer.showLevel()
		null

	update: =>
		@grid.update()
		@renderer.render @grid

		requestAnimationFrame  @update
		null

	preloadImages: ->
		images = [
			'img/plain-tile.jpg'
		]
		@loader = new PIXI.AssetLoader(images)
		@loader.onComplete = @init
		@loader.load()
		null

	handleTouch: (e) =>
		e.preventDefault()
		# @debug.innerHTML = 'TTTOOOUUUUCCCHHH!!!'
		xFromCenter = (320*@gameScale) - (e.touches[0].pageX-@leftMargin)
		xneg = false
		yneg = false
		if xFromCenter < 0
			xFromCenter *= -1
			xneg = true
		yFromCenter = (320*@gameScale) - (e.touches[0].pageY-@topMargin)
		if yFromCenter < 0
			yFromCenter *= -1
			yneg = true
		# @debug.innerHTML = (e.touches[0].pageX-@leftMargin)+'_'+(e.touches[0].pageY-@topMargin)
		if yFromCenter > xFromCenter
			if yneg then @downPressed = true else @upPressed = true
		else if xneg then @rightPressed = true
		else @leftPressed = true

		null

	handleKeyPress: (e) =>
		unicode = if e.keyCode then e.keyCode else e.charCode
		if unicode is 37 or unicode is 65
			@leftPressed = true
		if unicode is 39 or unicode is 68
			@rightPressed = true
		if unicode is 38 or unicode is 87
			@upPressed = true
		if unicode is 40 or unicode is 83
			@downPressed = true
		null

	handleKeyRelease: (e) =>
		unicode = if e.keyCode then e.keyCode else e.charCode
		if unicode is 37 or unicode is 65
			@leftPressed = false
		if unicode is 39 or unicode is 68
			@rightPressed = false
		if unicode is 38 or unicode is 87
			@upPressed = false
		if unicode is 40 or unicode is 83
			@downPressed = false
		if unicode is 69
			@toggleEditMode()
		if unicode >= 48 and unicode <= 57
			@renderer.editState = @editStates[unicode-48]
		if unicode == 80
			@renderer.editState = 'pickup'
		if unicode == 82
			@reset()
		null

	toggleEditMode: =>
		@editMode = !@editMode
		null

	parseCurrentLevel: =>
		console.log 'PARSING'
		levelData = @grid.getLevelData()
		console.log levelData
		text = @parseLevelData levelData
		null

	reset: =>
		@renderer.hideLevel =>
			@grid.createGrid @levels[@currentLevel]
			@renderer.showLevel()
		null

	parseLevelData: (data) =>
		console.log 'READING DATA :: '+data
		str = ''
		str += 'pickups:{\n'
		for pickup of data.pickups
			str += '"'+pickup+'" : "'+data.pickups[pickup]+'",\n'
		str += '},\n'
		str += 'startPos:{\n'
		str += 'x:'+data.startPos.x+',\ny:'+data.startPos.y+'\n'
		str += '},\n'
		for tile of data
			if tile != 'pickups' and tile != 'startPos'
				str += '"'+tile+'" : "'+data[tile]+'",\n'
		console.log 'LEVEL STRING = \n'+str
		return str