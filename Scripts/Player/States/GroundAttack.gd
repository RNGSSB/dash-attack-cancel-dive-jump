extends State


func Exit():
	owner.ctrl = 1
	owner.attacking = false
	owner.breakWalls = false

func Enter():
	owner.bufferAttack = false
	owner.breakWalls = true
	owner.ctrl = 0
	owner.attacking = true
	if owner.inputY > 0:
		owner.animation.play("UPTILT")
		owner.hitboxChange(0)
	elif owner.inputY < 0:
		owner.animation.play("DOWNTILT")
		owner.hitboxChange(1)
	else:
		owner.animation.play("JAB")
		owner.hitboxChange(0)

func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	
	owner.velocity.x -= min(abs(owner.velocity.x), owner.groundBrake) * sign(owner.velocity.x)
	
	if !owner.is_on_floor():
		Transitioned.emit(self, "air")
	
	if owner.stateFrame == 15:
		if !owner.rayCeilingRight.is_colliding() and !owner.rayCeilingLeft.is_colliding():
			Transitioned.emit(self, "idle")
		else:
			Transitioned.emit(self, "slide")
