extends State


func Exit():
	owner.hitboxChange(0)

func Enter():
	owner.isGrounded = true
	owner.ctrl = 1
	if owner.inputY < 0:
		owner.hitboxChange(1)
		owner.animation.play("CROUCH")
	else:
		owner.hitboxChange(0)
		owner.animation.play("IDLE")


func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	if owner.inputY < 0:
		owner.hitboxChange(1)
		owner.animation.play("CROUCH")
	else:
		owner.hitboxChange(0)
		owner.animation.play("IDLE")
	
	if !owner.is_on_floor():
		Transitioned.emit(self, "air")
	owner.velocity.x -= min(abs(owner.velocity.x), owner.groundBrake) * sign(owner.velocity.x)
