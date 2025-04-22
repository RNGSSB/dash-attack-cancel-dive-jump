extends State


func Exit():
	pass

func Enter():
	owner.ctrl = 0
	owner.airControl = 0
	owner.velocity.y = -1000
	owner.velocity.x = 0
	AudioManager.death.play()
	owner.set_collision_mask_value(1, false)
	owner.set_collision_mask_value(8, false)
	owner.set_collision_mask_value(4, false)
	owner.area2d.set_collision_mask_value(4, false)
	owner.hubris.set_collision_mask_value(4, false)
	owner.animation.play("DEATH")
	owner.playerArea.process_mode = Node.ProcessMode.PROCESS_MODE_DISABLED

func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	owner.playerSprite.rotation += 1
	if owner.velocity.y > 0:
		owner.velocity.y *= 4
	if owner.stateFrame == 60:
		get_node(Common.GameManagerRef).Respawn()
