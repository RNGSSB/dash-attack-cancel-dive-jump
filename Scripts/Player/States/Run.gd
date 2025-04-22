extends State


func walkStuff():	
	if owner.inputX > 0:
		owner.playerSprite.scale.x = abs(owner.playerSprite.scale.x)
		owner.dir = 1
		if owner.velocity.x < 0:
			Transitioned.emit(self, "runturn")
		elif owner.velocity.x < owner.runSpeed:
			owner.velocity.x += owner.runAccel
			if owner.velocity.x > owner.runSpeed:
				owner.velocity.x = owner.runSpeed
		if owner.velocity.x > owner.runSpeed:
				owner.velocity.x -= min(abs(owner.velocity.x), owner.groundBrake) * sign(owner.velocity.x)
	elif owner.inputX < 0:
		owner.playerSprite.scale.x = abs(owner.playerSprite.scale.x) * -1
		owner.dir = -1
		if owner.velocity.x > 0:
			Transitioned.emit(self, "runturn")
		elif owner.velocity.x > -owner.runSpeed:
			owner.velocity.x -= owner.runAccel
			if owner.velocity.x <= -owner.runSpeed:
				owner.velocity.x = -owner.runSpeed
		if owner.velocity.x <= -owner.runSpeed:
				owner.velocity.x -= min(abs(owner.velocity.x), owner.groundBrake) * sign(owner.velocity.x)
	elif owner.inputX == 0:
		owner.velocity.x -= min(abs(owner.velocity.x), owner.groundBrake) * sign(owner.velocity.x)

func Enter():
	owner.isGrounded = true
	owner.animation.play("RUN")

func Exit():
	owner.animation.stop()

func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	
	walkStuff()
	
	if owner.inputX == 0 or (!Input.is_action_pressed("Run") and !Input.is_action_pressed("RunKey")):
		Transitioned.emit(self, "skid")
	
	if !owner.is_on_floor():
		Transitioned.emit(self, "air")
	if owner.velocity.x == 0:
		Transitioned.emit(self, "idle")
