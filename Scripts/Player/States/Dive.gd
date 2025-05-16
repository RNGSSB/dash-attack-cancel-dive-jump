extends State


var reverse = false
var framesMidAir = 0
var soundTime = 0.11

var spikeSave = true

func airAccelStuff():
	if owner.inputX > 0:
		if owner.velocity.x < 0:
			owner.velocity.x += owner.airDeccelX * 0.4
		elif owner.velocity.x < owner.airSpeedX:
			owner.velocity.x += owner.airAccelX * 0.4
		elif owner.velocity.x > owner.airSpeedX:
			owner.velocity.x -= min(abs(owner.velocity.x), owner.airBrake) * sign(owner.velocity.x)
	elif owner.inputX < 0:
		if owner.velocity.x > 0:
			owner.velocity.x -= owner.airDeccelX * 0.4
		elif owner.velocity.x > -owner.airSpeedX:
			owner.velocity.x -= owner.airAccelX * 0.4
		elif owner.velocity.x < -owner.airSpeedX:
			owner.velocity.x -= min(abs(owner.velocity.x), owner.airBrake) * sign(owner.velocity.x)
	elif owner.inputX == 0:
		owner.velocity.x -= min(abs(owner.velocity.x), owner.airBrake) * sign(owner.velocity.x)


func Exit():
	owner.canTurn = true
	owner.ctrl = 1
	owner.airControl = true
	owner.hitboxChange(0)
	owner.slideParticles.emitting = false
	reverse = false

func Enter():
	AudioManager.dive.play()
	owner.diveParticles.emitting = true
	owner.bufferDive = false
	owner.airControl = false
	owner.divenum = 0
	owner.ctrl = 0
	owner.isGrounded = false
	spikeSave = true
	owner.canTurn = false
	owner.animation.play("DIVESTART")
	framesMidAir = 0
	owner.hitboxChange(1)

func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	if owner.stateFrame <= 4 and !reverse:
		if owner.inputX != 0 and owner.inputX != owner.dir:
			owner.dir *= -1
			owner.velocity.x = owner.diveSpeedX * owner.dir
			print("fixed your input dumbass")
			reverse = true
	
	soundTime -= delta
	if soundTime < 0.0 and owner.is_on_floor() and owner.velocity.x != 0:
		AudioManager.slide.play()
		soundTime = 0.11
	
	if owner.stateFrame == 4:
		owner.animation.play("DIVEAIR")
		AudioManager.jump.stop()
	
	if owner.is_on_floor():
		if !owner.isGrounded:
			owner.invincibleTimer = 1
		owner.isGrounded = true
		framesMidAir = 0
		if abs(owner.velocity.x) > 500:
			owner.slideParticles.emitting = true
		owner.velocity.y = 0
		if owner.velocity.x != 0:
			owner.dir = sign(owner.velocity.x)
		owner.velocity.x += 60 * owner.get_floor_normal()[0]
		owner.velocity.x -= min(abs(owner.velocity.x), 60 * 0.4) * sign(owner.velocity.x)
		if owner.animation.current_animation != "DIVESLIDE":
			owner.animation.play("DIVESLIDE")
	else:
		owner.isGrounded = false
		owner.slideParticles.emitting = false
		var rotationVel = owner.velocity.y
		if rotationVel > 600:
			rotationVel = 600
		if framesMidAir > 90:
			framesMidAir = 90
		
		owner.playerSprite.rotation = (deg_to_rad(rotationVel) * owner.dir) * 0.05
		#owner.playerArea.rotation = (deg_to_rad(rotationVel) * owner.dir) * 0.05
		airAccelStuff()
	
	if owner.is_on_floor() and (owner.bufferJump or owner.bufferDive) and !owner.rayCeilingRight.is_colliding() and !owner.rayCeilingLeft.is_colliding() and (owner.get_real_velocity()[1] > 0 and owner.get_floor_angle() != 0 or owner.get_floor_angle() == 0):
		if owner.inputX == owner.dir:
			owner.velocity.x = owner.velocity.x + owner.diveHopSpeedX * owner.dir
		owner.velocity.y = owner.diveHopSpeedY
		owner.animation.play("DIVEFINISH")
		owner.hitboxChange(0)
		owner.bufferDive = false
		owner.bufferJump = false
		AudioManager.diveHop.play()
		owner.invincibleTimer = 3
		Transitioned.emit(self, "air")
	
	if owner.is_on_floor() and owner.velocity.x == 0 and owner.get_floor_angle() == 0:
		if !owner.rayCeilingRight.is_colliding() and !owner.rayCeilingLeft.is_colliding():
			owner.hitboxChange(0)
			owner.animation.stop()
			Transitioned.emit(self, "idle")
		else:
			owner.velocity.x = 300 * owner.dir
