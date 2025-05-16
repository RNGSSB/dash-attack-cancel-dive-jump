extends State


func Exit():
	owner.ctrl = 1

func Enter():
	AudioManager.land.play()
	owner.ctrl = 0
	owner.velocity.y = 0
	owner.animation.play("LANDING")

func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	if owner.is_on_floor() and owner.bufferJump:
		Transitioned.emit(self, "jump")
	elif owner.is_on_floor() and owner.bufferAttack and (Input.is_action_pressed("Run") or Input.is_action_pressed("RunKey")):
		Transitioned.emit(self, "dashattack")
	elif owner.is_on_floor() and owner.bufferAttack and (!Input.is_action_pressed("Run") and !Input.is_action_pressed("RunKey")):
		Transitioned.emit(self, "groundattack")
	elif !owner.is_on_floor():
		Transitioned.emit(self, "air")
	else:
		Transitioned.emit(self, "idle")
