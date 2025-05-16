extends State


func Exit():
	pass

func Enter():
	owner.endParticles.emitting = true
	owner.velocity.x = 0
	owner.velocity.y = 0
	owner.ctrl = 0
	owner.airControl = false
	owner.airPhysics = false
	owner.playerSprite.visible = false

func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	pass
