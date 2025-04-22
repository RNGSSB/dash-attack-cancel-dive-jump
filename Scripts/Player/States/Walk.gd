extends State


func walkStuff():
	if owner.inputX > 0:
		owner.playerSprite.scale.x = abs(owner.playerSprite.scale.x)
		owner.dir = 1
		if owner.velocity.x < 0:
			owner.velocity.x += owner.walkAccel
		elif owner.velocity.x < owner.walkSpeed:
			owner.velocity.x += owner.walkAccel
			if owner.velocity.x > owner.walkSpeed:
				owner.velocity.x = owner.walkSpeed
		if owner.velocity.x > owner.walkSpeed:
				owner.velocity.x -= min(abs(owner.velocity.x), owner.groundBrake) * sign(owner.velocity.x)
	elif owner.inputX < 0:
		owner.playerSprite.scale.x = abs(owner.playerSprite.scale.x) * -1
		owner.dir = -1
		if owner.velocity.x > 0:
			owner.velocity.x -= owner.walkAccel
		elif owner.velocity.x > -owner.walkSpeed:
			owner.velocity.x -= owner.walkAccel
			if owner.velocity.x <= -owner.walkSpeed:
				owner.velocity.x = -owner.walkSpeed
		if owner.velocity.x <= -owner.walkSpeed:
				owner.velocity.x -= min(abs(owner.velocity.x), owner.groundBrake) * sign(owner.velocity.x)
	elif owner.inputX == 0:
		owner.velocity.x -= min(abs(owner.velocity.x), owner.groundBrake) * sign(owner.velocity.x)

func Enter():
	owner.isGrounded = true
	owner.animation.play("WALK")

func Exit():
	owner.animation.stop()

func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	
	walkStuff()
	
	if !owner.is_on_floor():
		Transitioned.emit(self, "air")
	if owner.velocity.x == 0:
		Transitioned.emit(self, "idle")
