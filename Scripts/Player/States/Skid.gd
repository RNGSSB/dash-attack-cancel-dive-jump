extends State


func Exit():
	owner.animation.stop()

func Enter():
	owner.animation.play("SKID")

func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	if !owner.is_on_floor():
		Transitioned.emit(self, "air")
	
	if owner.velocity.x == 0:
		Transitioned.emit(self, "idle")
	owner.velocity.x -= min(abs(owner.velocity.x), owner.groundBrake) * sign(owner.velocity.x)
