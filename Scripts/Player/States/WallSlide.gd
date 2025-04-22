extends State



var soundTime = 0.11
func Exit():
	owner.airPhysics = true
	owner.airControl = true
	owner.animation.stop()
	owner.ctrl = 1
	owner.wallParticles.emitting = false

func Enter():
	owner.airPhysics = false
	owner.airControl = false
	AudioManager.wallCling.play()
	owner.animation.play("WALLSLIDE")
	owner.playerSprite.scale.x = abs(owner.playerSprite.scale.x) * owner.dir
	owner.velocity.x = 100 * owner.dir
	owner.velocity.y = 0
	owner.ctrl = 0
	owner.airStall = true

func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	soundTime -= delta
	if soundTime < 0.0:
		AudioManager.slide.play()
		soundTime = 0.11
	
	if owner.velocity.y > 400:
		owner.wallParticles.emitting = true
	
	owner.velocity.y += owner.wallBrake
	
	if owner.bufferJump:
		owner.velocity.x = owner.wallVelX * -owner.dir
		owner.velocity.y = owner.wallVelY 
		AudioManager.wallCling.stop()
		AudioManager.slide.stop()
		AudioManager.jump.play()
		Transitioned.emit(self, "air")
	
	if owner.is_on_floor():
		Transitioned.emit(self, "idle")
	if !owner.rayRight.is_colliding() and owner.dir > 0 or !owner.rayLeft.is_colliding() and owner.dir < 0:
		Transitioned.emit(self, "air")
