extends State


func Exit():
	owner.hitboxChange(0)

func Enter():
	owner.isGrounded = true
	owner.ctrl = 1
	if owner.inputY < 0:
		owner.hitboxChange(1)
		owner.animation.queue("CROUCHIDLE")
	else:
		owner.hitboxChange(0)
		owner.animation.queue("IDLE")


func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	if owner.inputY < 0:
		if owner.standingHitbox.disabled == false and owner.animation.current_animation == "":
			owner.animation.queue("CROUCH")
			owner.animation.queue("CROUCHIDLE")
			owner.hitboxChange(1)
	else:
		if owner.standingHitbox.disabled == true and owner.animation.current_animation == "":
			owner.animation.queue("CROUCHUP")
			owner.animation.queue("IDLE")
			owner.hitboxChange(0)
	
	if !owner.is_on_floor():
		Transitioned.emit(self, "air")
	owner.velocity.x -= min(abs(owner.velocity.x), owner.groundBrake) * sign(owner.velocity.x)
