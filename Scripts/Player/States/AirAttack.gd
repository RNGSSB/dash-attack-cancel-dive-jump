extends State


func Exit():
	owner.ctrl = 1
	owner.airDashAttack = false
	owner.canTurn = true
	owner.attacking = false
	owner.breakWalls = false

func Enter():
	owner.ctrl = 0
	owner.bufferAttack = false
	owner.isGrounded = false
	owner.canTurn = false
	owner.attacking = true
	owner.breakWalls = true
	
	if (Input.is_action_pressed("Run") or Input.is_action_pressed("RunKey")):
		owner.animation.play("AIRDASHATTACK")
		owner.airDashAttack = true
	else:
		if owner.inputY == 0:
			owner.animation.play("NEUTRALAIR")
		else:
			owner.animation.play("UPAIR")

func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	
	if !owner.airDashAttack:
		if owner.airStall and owner.stateFrame < 15:
			owner.velocity.x *= 0.8
			owner.velocity.y *= 0.8
		else:
			owner.airStall = false
	
	if owner.is_on_floor():
		Transitioned.emit(self, "landing")
	
	if owner.stateFrame == 25:
		Transitioned.emit(self, "air")
