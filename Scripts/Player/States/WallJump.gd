extends State


func Exit():
	pass

func Enter():
	owner.airPhysics = true
	owner.airControl = true
	owner.bufferJump = false
	owner.isGrounded = false
	owner.ctrl = 1
	owner.velocity.x = owner.wallVelX * -owner.dir
	
	if (Input.is_action_pressed("Jump") || Input.is_action_pressed("JumpKey")):
		owner.velocity.y = owner.wallVelY 
	else:
		owner.velocity.y = owner.wallVelY / 2 
	AudioManager.wallCling.stop()
	AudioManager.slide.stop()
	AudioManager.jump.play()
	owner.animation.play("FALL")

func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	if (Input.is_action_just_released("Jump") || Input.is_action_just_released("JumpKey")) and owner.velocity.y < 0:
		owner.velocity.y /= 2
	
	if owner.is_on_floor():
		Transitioned.emit(self, "landing")
