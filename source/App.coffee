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

	leftDigit: null
	rightDigit: null

	gameScale: 1

	lights: true

	perfect: true

	menuOpen: true
	overOpen: false

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
			{url:'img/player-down.png', id:'player-down'},
			{url:'img/player-up.png', id:'player-up'},
			{url:'img/player-left.png', id:'player-left'},
			{url:'img/player-right.png', id:'player-right'},
			{url:'img/touch-screen.jpg', id:'touch-screen'},
			{url:'img/keyboard-screen.jpg', id:'keyboard-screen'}
		]
		@textures = new GameTextures(images)
		@textures.load @init

		$('#next-button').bind 'click touchstart', @nextClicked

		@menu = $('#game-menu-holder')
		@over = $('#game-over-holder')
		$('#game-over-holder').css('opacity', '0').remove()

	startClick: =>
		TweenMax.to $('#start-screen'), 0.5, {css:{opacity:0}, ease:Power4.easeOut, onComplete:=>
			$('#start-screen').remove()
		}
		null

	init: =>

		$('#start-screen').html ''
		if Modernizr.touch
			$('#start-screen').css 'background', 'url("img/touch-screen.jpg") 0 0 no-repeat'
		else
			$('#start-screen').css 'background', 'url("img/keyboard-screen.jpg") 0 0 no-repeat'
		$('#start-screen').bind 'click touchstart', @startClick

		@leftDigit = $('#digit_0')
		@rightDigit = $('#digit_1')

		@levels = Levels.Levels
		# @currentLevel = @levels.length-1

		@updateDigits()

		@grid = new GameGrid @levelComplete
		@grid.createGrid @levels[@currentLevel]

		@renderer = new GameRenderer document.getElementById('canvas-holder')

		window.onresize = @resize
		@resize()

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

		$('#game-holder').css 'transform', 'scale('+@gameScale+', '+@gameScale+')'

		null


	nextClicked: =>
		$('#next-button').unbind 'click touchstart', @nextClicked
		TweenMax.to @menu, 0.5, {css:{opacity:0}, ease:Power4.easeOut, onComplete:=>
			@menuOpen = false
			$('#game-menu-holder').remove()
			@renderer.showLevel()
		}
		null

	updateLights: =>
		if @lights
			$('#game-menu').css 'background-position-y', '0'
			console.log 'bg to 0'
		else
			$('#game-menu').css 'background-position-y', '-512px'
			console.log 'bg to -512'
		null

	updateDigits: =>
		lvl = @currentLevel + 1
		t = Math.floor(lvl/10)
		u = lvl - (10 * t)
		$(@leftDigit).css 'background-position-y', -(t*160)+'px'
		$(@rightDigit).css 'background-position-y', -(u*160)+'px'
		null

	levelComplete: =>
		@renderer.hideLevel =>
			
			if @grid.tilesToDrop == 0 then @lights = true else @lights = false
			if !@lights then @perfect = false
			@currentLevel++
			# if @currentLevel == @levels.length then @currentLevel = 0
			if @currentLevel == 20
				@showGameComplete()
				return
			@menuOpen = true
			@updateDigits()
			@grid.createGrid @levels[@currentLevel]
			$('#game-holder').append @menu
			@updateLights()
			TweenMax.to @menu, 0.5, {css:{opacity:1}, ease:Power4.easeOut, onComplete:=>
				$('#next-button').bind 'click touchstart', @nextClicked
			}
		null

	showGameComplete: =>
		bgPos = 0
		if @perfect then bgPos = -512
		$('#game-holder').append @over
		$('#game-over').css 'background-position-y', bgPos+'px'
		TweenMax.to @over, 0.5, {css:{opacity:1}, ease:Power4.easeOut, onComplete:=>
			$('#replay-button').bind 'click touchstart', @replayClicked
		}
		null

	replayClicked: =>
		$('#replay-button').unbind 'click touchstart', @replayClicked
		TweenMax.to @over, 0.5, {css:{opacity:0}, ease:Power4.easeOut, onComplete:=>
			@overOpen = false
			$('#game-over-holder').remove()
			@reset()
		}
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
		if e.touches.length > 2
			@reset()
			return

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
		if yFromCenter > xFromCenter
			if yneg then @downPressed = true else @upPressed = true
		else if xneg then @rightPressed = true
		else @leftPressed = true

		null

	handleKeyPress: (e) =>
		if @menuOpen or @overOpen then return
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
		if @menuOpen or @overOpen and unicode is 32
			@nextClicked()
		if unicode is 37 or unicode is 65
			@leftPressed = false
		if unicode is 39 or unicode is 68
			@rightPressed = false
		if unicode is 38 or unicode is 87
			@upPressed = false
		if unicode is 40 or unicode is 83
			@downPressed = false
		if unicode == 82
			@reset()
		###
		if unicode is 69
			@toggleEditMode()
		if unicode >= 48 and unicode <= 57
			@renderer.editState = @editStates[unicode-48]
		if unicode == 80
			@renderer.editState = 'pickup'
		###
		
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
		if @menuOpen or @overOpen then return
		@renderer.hideLevel =>
			@menuOpen = true
			@perfect = true
			@lights = true
			@currentLevel = 0
			@updateDigits()
			@updateLights()
			@grid.createGrid @levels[@currentLevel]
			$('#game-holder').append @menu
			TweenMax.to @menu, 0.5, {css:{opacity:1}, ease:Power4.easeOut, onComplete:=>
				$('#next-button').bind 'click touchstart', @nextClicked
			}
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