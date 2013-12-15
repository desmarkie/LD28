class EditPanel

	view: null

	sprites: []

	constructor: ->
		@view = new PIXI.DisplayObjectContainer()
		arr = ['normal', 'metal', 'corner']
		for i in [0..arr.length-1]
			sp = new PIXI.Sprite window.app.textures.getTexture(arr[i])
			sp.position.x = (i * 64) % 576
			sp.position.y = Math.floor(i / 64) * 64
			@sprites.push {sprite:sp, id:arr[i]}
			@view.addChild sp

	enable: =>
		for sp in @sprites
			sp.sprite.interactive = true
			sp.sprite.onclick = @spriteClick
		null

	disable: =>
		for sp in @sprites
			sp.sprite.interactive = false
			sp.sprite.onclick = null
		null

	spriteClick: (e) =>
		e.stopPropagation()
		for sp in @sprites
			if sp.sprite is e.target
				console.log 'SELECTED : '+sp.id
		null