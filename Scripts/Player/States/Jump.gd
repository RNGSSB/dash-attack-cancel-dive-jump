extends State

var deez = true
var floatJump = true
func Exit():
	if deez:
		owner.velocity.y *= 0.45
	deez = true
	floatJump = true

func Enter():
	AudioManager.jump.play()
	AudioManager.land.stop()
	AudioManager.dash.stop()
	owner.bufferJump = false
	owner.isGrounded = false
	owner.animation.play("JUMP")
	deez = true
	floatJump = true
	if (!Input.is_action_pressed("Jump") and !Input.is_action_pressed("JumpKey")):
		owner.velocity.y = owner.jumpVel1 * 0.2
	else:
		owner.velocity.y = owner.jumpVel1 * 2
	
	

func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	if owner.stateFrame > 4 and deez and (Input.is_action_pressed("Jump") or Input.is_action_pressed("JumpKey")):
		owner.velocity.y *= 0.38
		deez = false
	
	
	if owner.velocity.y > 0 and owner.stateFrame < 30 and (Input.is_action_pressed("Jump") or Input.is_action_pressed("JumpKey")) and floatJump:
		owner.velocity.y *= 0.9
	
	if owner.velocity.y > 0:
		owner.animation.queue("JUMPEND")
		owner.animation.queue("FALL")
	
	if owner.is_on_ceiling():
		floatJump = false
	
	if (Input.is_action_just_released("Jump") or Input.is_action_just_released("JumpKey")) and owner.velocity.y < 0 and owner.velocity.y < owner.jumpVel1 * 0.2:
		floatJump = false
		owner.velocity.y = owner.jumpVel1 * 0.2
	
	if owner.is_on_floor():
		Transitioned.emit(self, "landing")
