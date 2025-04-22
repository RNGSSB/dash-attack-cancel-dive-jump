extends State


func Exit():
	owner.airControl = true
	owner.ctrl = 1

func Enter():
	owner.HP -= 1
	owner.velocity.y = -640
	owner.velocity.x = 300 * owner.dir * -1
	owner.animation.play("DAMAGE")
	owner.airControl = false
	owner.ctrl = 0

func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	if owner.HP <= 0:
		print("dead")
		Transitioned.emit(self, "death")
	
	if owner.stateFrame == 15:
		owner.airControl = true
	
	if owner.is_on_floor():
		owner.velocity.x -= min(abs(owner.velocity.x), owner.groundBrake) * sign(owner.velocity.x)
		
		if owner.stateFrame == 30:
			Transitioned.emit(self, "idle")
	else:
		if owner.stateFrame == 30:
			Transitioned.emit(self, "air")
