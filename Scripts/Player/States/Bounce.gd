extends State

var deez = true
var floatJump = true
func Exit():
	pass

func Enter():
	owner.bufferJump = false
	owner.isGrounded = false
	owner.animation.play("JUMP")
	owner.velocity.y = owner.jumpVel2
	if (!Input.is_action_pressed("Jump") and !Input.is_action_pressed("JumpKey")):
		owner.velocity.y = owner.jumpVel1 * 0.5
	
	

func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	
	if (Input.is_action_just_released("Jump") or Input.is_action_just_released("JumpKey")) and owner.velocity.y < 0 and owner.velocity.y < owner.jumpVel1 * 0.5:
		owner.velocity.y = owner.jumpVel1 * 0.5
	
	if owner.is_on_floor():
		Transitioned.emit(self, "landing")
