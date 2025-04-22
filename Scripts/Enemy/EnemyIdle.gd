extends State


func Exit():
	pass

func Enter():
	pass

func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	if owner.is_on_wall():
		owner.flipEnemy()
	
	if owner.is_on_floor():
		pass
	else:
		owner.velocity.y += owner.GRAVITY
	
	if (!owner.raycastLeft.is_colliding() and owner.DIR == -1 or !owner.raycastRight.is_colliding() and owner.DIR == 1) and !owner.WALKOFF and owner.is_on_floor():
		owner.flipEnemy()
	
	owner.velocity.x = owner.SPEED * owner.DIR
