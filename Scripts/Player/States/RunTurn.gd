extends State

var soundTime = 0.11
func Exit():
	owner.animation.stop()

func Enter():
	owner.isGrounded = true
	owner.animation.play("RUNTURN")

func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	soundTime -= delta
	if soundTime < 0.0 and owner.is_on_floor() and owner.velocity.x != 0:
		AudioManager.skid.play()
		soundTime = 0.11
	
	
	owner.velocity.x -= min(abs(owner.velocity.x), owner.runDeccel) * sign(owner.velocity.x)
	
	if owner.velocity.x == 0:
		Transitioned.emit(self, "idle")
	if !owner.is_on_floor():
		Transitioned.emit(self, "air")
