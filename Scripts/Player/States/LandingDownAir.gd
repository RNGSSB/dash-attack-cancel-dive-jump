extends State


func Exit():
	owner.ctrl = 1

func Enter():
	AudioManager.dairLand.play()
	AudioManager.dairFire.stop()
	owner.ctrl = 0
	owner.animation.play("DOWNAIRLANDING")
	owner.stompParticles.emitting = true

func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	if owner.is_on_floor() and owner.bufferAttack and (Input.is_action_pressed("Run") or Input.is_action_pressed("RunKey")):
		Transitioned.emit(self, "dashattack")
	
	if owner.is_on_floor() and owner.bufferJump:
		Transitioned.emit(self, "jump")
	
	if owner.is_on_floor() and owner.bufferDive:
		if owner.inputX != 0:
			owner.velocity.x = (owner.diveSpeedX * 1.5) * owner.inputX
			owner.dir = owner.inputX
		else:
			owner.velocity.x = (owner.diveSpeedX * 1.5) * owner.dir
		owner.velocity.y = owner.diveSpeedY
		Transitioned.emit(self, "dive")
	
	if !owner.is_on_floor():
		Transitioned.emit(self, "air")
	
	if owner.get_floor_angle() != 0:
		#owner.velocity.x = (owner.stompVelY * 0.8) * owner.dir
		owner.velocity.y = 0
		Transitioned.emit(self, "slide")
	
	if owner.stateFrame == 16:
		Transitioned.emit(self, "idle")
