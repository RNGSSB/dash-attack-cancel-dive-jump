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
	
	if owner.is_on_floor() and owner.bufferAttack and (Input.is_action_pressed("Run") or Input.is_action_pressed("RunKey")):
		Transitioned.emit(self, "dashattack")
	
	if owner.is_on_floor() and owner.bufferAttack and (!Input.is_action_pressed("Run") and !Input.is_action_pressed("RunKey")):
		Transitioned.emit(self, "groundattack")
	
	if !owner.is_on_floor():
		Transitioned.emit(self, "air")
	
	if owner.stateFrame == 5:
		Transitioned.emit(self, "idle")
