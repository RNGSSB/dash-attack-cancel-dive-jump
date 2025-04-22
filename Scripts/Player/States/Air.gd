extends State


func Exit():
	pass

func Enter():
	owner.isGrounded = false
	owner.animation.queue("FALL")

func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	if owner.bufferJump and owner.stateFrame < 5 and (owner.PREVSTATE == "Idle" or owner.PREVSTATE == "Walk" or owner.PREVSTATE == "Run" or owner.PREVSTATE == "RunTurn" or owner.PREVSTATE == "Skid" or owner.PREVSTATE == "Crouch" or owner.PREVSTATE == "Landing" or owner.PREVSTATE == "Slide"):
		print("Coyote Jump!")
		Transitioned.emit(self, "jump")
	
	if owner.is_on_floor():
		Transitioned.emit(self, "landing")
