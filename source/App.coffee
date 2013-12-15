# import renderer.*
# import model.*
class App

	renderer: null
	textures: null

	upPressed: false
	downPressed: false
	leftPressed: false
	rightPressed: false

	editMode: false

	editStates: ['normal', 'metal', 'corner']

	constructor: ->
		images = [
			{url:'img/pickup_01.png', id:'pickup_01'},
			{url:'img/pickup_02.png', id:'pickup_02'},
			{url:'img/pickup_03.png', id:'pickup_03'},
			{url:'img/pickup_04.png', id:'pickup_04'},
			{url:'img/pickup_05.png', id:'pickup_05'},
			{url:'img/bg.jpg', id:'bg'},
			{url:'img/metal-tile.jpg', id:'metal'},
			{url:'img/corner-tile.jpg', id:'corner'},
			{url:'img/plain-tile.png', id:'normal'},
			{url:'img/player.png', id:'player'}
		]
		@textures = new GameTextures(images)
		@textures.load @init

		$('#parse-button').bind 'click', @parseCurrentLevel

	init: =>
		@grid = new GameGrid @levelComplete

		@renderer = new GameRenderer document.getElementById('game-holder')
		@renderer.showLevel()

		window.onkeydown = @handleKeyPress
		window.onkeyup = @handleKeyRelease

		requestAnimationFrame @update
		null

	levelComplete: =>
		@renderer.hideLevel =>
			@grid.createGrid Levels.LevelOne
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

	handleKeyPress: (e) =>
		#37 or 65 is left
		#39 or 68 is right
		#38 or 87 is up
		#40 or 83 is down
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
			@renderer.hideLevel =>
				@grid.createGrid Levels.LevelOne
				@renderer.showLevel()
		null

	toggleEditMode: =>
		@editMode = !@editMode
		# if @editMode then @renderer.showEditPanel() else @renderer.hideEditPanel()
		null

	parseCurrentLevel: =>
		console.log 'PARSING'
		levelData = @grid.getLevelData()
		console.log levelData
		text = @parseLevelData levelData
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