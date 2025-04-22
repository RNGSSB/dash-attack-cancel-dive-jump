extends State


func Exit():
	owner.airControl = true
	owner.airPhysics = true
	owner.attacking = false
	owner.canFastFall = true
	owner.breakWalls = false
	owner.animation.stop()
	owner.ctrl = 1

func Enter():
	AudioManager.dairStart.play()
	owner.animation.play("DOWNAIR")
	owner.velocity.x = 0
	owner.velocity.y = 0
	owner.bufferAttack = false
	owner.airControl = false
	owner.airPhysics = false
	owner.attacking = true
	owner.canFastFall = false
	owner.breakWalls = true
	owner.ctrl = 0

func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	if owner.velocity.y < 0 and !owner.is_on_floor():
		Transitioned.emit(self, "air")
	
	if owner.stateFrame == 6:
		owner.velocity.y = owner.stompVelY
		owner.animation.play("DOWNAIRLOOP")
	
	if owner.stateFrame > 6:
		if !AudioManager.dairFire.is_playing():
			AudioManager.dairFire.play()
	
	if owner.bufferDive:
		if owner.inputX != 0:
			owner.velocity.x = owner.diveSpeedX * owner.inputX
			owner.dir = owner.inputX
		else:
			owner.velocity.x = owner.diveSpeedX * owner.dir
		owner.velocity.y = owner.diveSpeedY
		Transitioned.emit(self, "dive")
	
	if owner.is_on_floor():
		Transitioned.emit(self, "landingdownair")
