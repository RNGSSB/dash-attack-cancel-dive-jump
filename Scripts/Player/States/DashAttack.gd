extends State

var coyoteTimer = 0

func Exit():
	owner.ctrl = 1
	owner.attacking = false
	owner.animation.stop()
	owner.slideParticles.emitting = false
	owner.breakWalls = false
	owner.canFastFall = true

func Enter():
	AudioManager.dash.play()
	owner.attacking = true
	owner.canFastFall = false
	owner.bufferAttack = false
	if owner.inputX != 0:
		owner.dir = owner.inputX
	owner.velocity.x = owner.dashAttackSpeedX * owner.dir
	owner.animation.play("DASHATTACK")
	owner.ctrl = 0
	owner.slideParticles.emitting = true
	owner.breakWalls = true
	coyoteTimer = 0

func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	owner.velocity.x -= min(abs(owner.velocity.x), owner.groundBrake * 0.5) * sign(owner.velocity.x)
	
	if !owner.is_on_floor() and coyoteTimer == 0:
		coyoteTimer = owner.frameCounter
	
	if (owner.is_on_floor() or !owner.is_on_floor() and owner.frameCounter < coyoteTimer + 4) and owner.bufferJump:
		if !owner.is_on_floor():
			print("Coyote Jump!")
		Transitioned.emit(self, "jump")
	
	if owner.inputY < 0 and owner.stateFrame == 15 and owner.is_on_floor():
		Transitioned.emit(self, "slide")
	
	if owner.stateFrame == 20:
		owner.ctrl = 1
		if !owner.is_on_floor():
			Transitioned.emit(self, "air")
		else:
			Transitioned.emit(self, "idle")
	
	
