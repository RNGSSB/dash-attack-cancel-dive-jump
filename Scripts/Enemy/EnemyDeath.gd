extends State

var deathTimer = 10.0

func Exit():
	pass

func Enter():
	owner.enemyHitbox.disabled = true
	owner.enemyCollision.disabled = true
	AudioManager.damage.play()
	owner.velocity.x = 3000 * owner.DIR
	owner.velocity.y = -340
	owner.set_collision_mask_value(1, false)

func Update(_delta: float):
	pass

func Physics_Update(delta: float):
	deathTimer -= delta
	owner.enemySprite.rotation += 1
	owner.enemyHitbox.disabled = true
	owner.enemyCollision.disabled = true
	owner.velocity.y += owner.GRAVITY
	if deathTimer < 0:
		owner.queue_free()
