extends State

var soundTime = 0.11

func Exit():
	owner.ctrl = 1
	owner.hitboxChange(0)
	owner.velocity.y = 0
	owner.attacking = false
	owner.slideParticles.emitting = false
	owner.animation.stop()
	owner.breakWalls = false
	owner.animation.stop()

func Enter():
	owner.ctrl = 0
	owner.hitboxChange(1)
	owner.animation.play("SLIDE")
	owner.attacking = true
	owner.breakWalls = true

func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	soundTime -= delta
	if soundTime < 0.0 and owner.is_on_floor() and owner.velocity.x != 0:
		AudioManager.slide.play()
		soundTime = 0.11
	
	
	if owner.is_on_floor():
		owner.velocity.x += 60 * owner.get_floor_normal()[0]
		owner.velocity.y = 0
		if abs(owner.velocity.x) > 500:
			owner.slideParticles.emitting = true
		
		if owner.velocity.x != 0:
			owner.dir = sign(owner.velocity.x)
		if owner.is_on_floor() and owner.bufferAttack and (Input.is_action_pressed("Run") or Input.is_action_pressed("RunKey")) and !owner.rayCeilingRight.is_colliding() and !owner.rayCeilingLeft.is_colliding():
			Transitioned.emit(self, "dashattack")
		
		if owner.is_on_floor() and owner.bufferAttack and (!Input.is_action_pressed("Run") and !Input.is_action_pressed("RunKey")) and !owner.rayCeilingRight.is_colliding() and !owner.rayCeilingLeft.is_colliding():
			Transitioned.emit(self, "groundattack")
		
		if owner.is_on_floor() and owner.bufferAttack and (!Input.is_action_pressed("Run") and !Input.is_action_pressed("RunKey")) and (owner.rayCeilingRight.is_colliding() or owner.rayCeilingLeft.is_colliding()) and owner.inputY < 0:
			Transitioned.emit(self, "groundattack")
		
		owner.velocity.x -= min(abs(owner.velocity.x), 60 * 0.3) * sign(owner.velocity.x)
		
		if owner.bufferJump and !owner.rayCeilingRight.is_colliding() and !owner.rayCeilingLeft.is_colliding():
			Transitioned.emit(self, "jump")
		
		if owner.velocity.x == 0 and owner.get_floor_angle() == 0:
			if !owner.rayCeilingRight.is_colliding() and !owner.rayCeilingLeft.is_colliding():
				Transitioned.emit(self, "idle")
			else:
				owner.velocity.x = 300 * owner.dir
	else:
		Transitioned.emit(self, "air")
