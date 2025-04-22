extends CharacterBody2D

@onready var stateMachine = $StateMachine
@onready var playerSprite = $PlayerSprite
@onready var standingHitbox = $StandingHitbox
@onready var crouchHitbox = $CrouchHitbox
@onready var areaStandingHitbox = $Area2D/StandHitbox
@onready var areaCrouchHitbox = $Area2D/CrouchHitbox
@export var animation : AnimationPlayer
@export var rayRight : RayCast2D
@export var rayLeft : RayCast2D
@export var rayCeilingRight : RayCast2D
@export var rayCeilingLeft : RayCast2D
@export var playerArea : Area2D
@export var wallParticles : CPUParticles2D
@export var slideParticles : CPUParticles2D
@export var stompParticles : CPUParticles2D
@export var hubris : Area2D
@export var killyourselfplease : CollisionShape2D
@onready var area2d = $Area2D
@onready var hud = $PlayerUI/Timer

#GROUND PHYSICS
@export_group("Ground Physics")
@export var walkSpeed = 400
@export var runSpeed = 800
@export var runAccel = 20
@export var runDeccel = 40
@export var walkAccel = 20

#AIR PHYSICS
@export_group("Air Physics")
@export var airAccelX = 8
@export var airDeccelX = 8
@export var airAccelY = 100
@export var airSpeedX = 500
@export var airSpeedY = 1000

#FRICTION!!!
@export_group("Friction")
@export var groundBrake = 60
@export var airBrake = 20
@export var wallBrake = 20

#JUMPS!
@export_group("Jumps")
@export var jumpVel1 = -800
@export var jumpVel2 = -1000
@export var jumpVel3 = -1200
@export var sideVelX = 280
@export var sideVelY = -490
@export var wallVelX = 500
@export var wallVelY = -800

#DIVE
@export_group("Dive")
@export var diveSpeedX = 400
@export var diveSpeedY = -400
@export var diveHopSpeedX = 400
@export var diveHopSpeedY = -180

#STOMP
@export_group("Stomp")
@export var stompVelY = 400
@export var stompJumpVel = -500
@export var stompDiveVel = -800
@export var fastFall = 1000

#Dash Attack
@export_group("Dash Attack")
@export var dashAttackSpeedX = 1200

#RESOURCES
@export_group("Resources")
@export var maxHealth = 3
var divenum = 1
var dir = 1
var ctrl = 1
var HP = maxHealth
var PREVSTATE = "Air"
var CURRSTATE = "Air"
var attacking = false
var invincible = false
var breakWalls = false
var airPhysics = true
var airControl = true
var isGrounded = false
var stateFrame = 0
var frameCounter = 0.0
var minuteCounter = 0.0
var jumpBuffer = 0
var bufferJump = false
var diveBuffer = 0
var bufferDive = false
var attackBuffer = 0
var bufferAttack = false
var canTurn = true
var fuckyou = 0
var inputX = 0
var inputY = 0
var airStall = true
var airDashAttack = false
var fastFallBuffer = 0
var stopFastFallHold = false
var bufferFastFall = false
var canFastFall = true
var killyourselftimer = 0
var coins = 0
var capFallSpeed = false

func ready():
	HP = maxHealth
	frameCounter = 0.0
	fuckyou = 0
	divenum = 1
	hitboxChange(0)


func _enter_tree():
	playerArea.add_to_group("Player")
	add_to_group("Player")

func hitboxChange(id):
	if id == 0:
		standingHitbox.disabled = false
		crouchHitbox.disabled = true
		areaStandingHitbox.disabled = false
		areaCrouchHitbox.disabled = true
	if id == 1:
		standingHitbox.disabled = true
		crouchHitbox.disabled = false
		areaStandingHitbox.disabled = true
		areaCrouchHitbox.disabled = false

func airAccelStuff():
	if inputX > 0:
		if canTurn:
			dir = 1
		if velocity.x < 0:
			velocity.x += airDeccelX
		elif velocity.x < airSpeedX:
			velocity.x += airAccelX
		elif velocity.x > airSpeedX:
			velocity.x -= min(abs(velocity.x), airBrake) * sign(velocity.x)
	elif inputX < 0:
		if canTurn:
			dir = -1
		if velocity.x > 0:
			velocity.x -= airDeccelX
		elif velocity.x > -airSpeedX:
			velocity.x -= airAccelX
		elif velocity.x < -airSpeedX:
			velocity.x -= min(abs(velocity.x), airBrake) * sign(velocity.x)
	elif inputX == 0:
		velocity.x -= min(abs(velocity.x), airBrake) * sign(velocity.x)

func _process(delta):
	
	var controllerX = Input.get_axis("Left", "Right")
	var controllerY = Input.get_axis("Down", "Up")	
	
	var keyX = Input.get_axis("LeftKey", "RightKey")
	var keyY = Input.get_axis("DownKey", "UpKey")	
	
	if controllerX != 0 and keyX != 0:
		if controllerX != keyX:
			inputX = 0
		else:
			inputX = controllerX
	elif controllerX != 0 and keyX == 0:
		inputX = controllerX
	elif controllerX == 0 and keyX != 0:
		inputX = keyX
	elif controllerX == 0 and keyX == 0:
		inputX = 0
	
	if controllerY != 0 and keyY != 0:
		if controllerY != keyY:
			inputY = 0
		else:
			inputY = controllerY
	elif controllerY != 0 and keyY == 0:
		inputY = controllerY
	elif controllerY == 0 and keyY != 0:
		inputY = keyY
	elif controllerY == 0 and keyY == 0:
		inputY = 0
	
	#print(get_floor_normal())
	
	if frameCounter >= 36000.0:
		stateMachine.change_state("Death")
	
	if inputY < 0 and !bufferFastFall and !stopFastFallHold and !is_on_floor():
		fastFallBuffer = frameCounter
		stopFastFallHold = true
		bufferFastFall = true
	
	if inputY < 0:
		stopFastFallHold = true
	
	if inputY >= 0:
		stopFastFallHold = false
	
	if (Input.is_action_just_pressed("Jump") or Input.is_action_just_pressed("JumpKey")) and !bufferJump:
		print("Jump buffer attempt")
		jumpBuffer = frameCounter
		bufferJump = true
	
	if (Input.is_action_just_pressed("Dive") or Input.is_action_just_pressed("DiveKey")) and !bufferDive: 
		diveBuffer = frameCounter
		bufferDive = true
	
	if (Input.is_action_just_pressed("Attack") or Input.is_action_just_pressed("AttackKey")) and !bufferAttack:
		attackBuffer = frameCounter
		bufferAttack = true
	
	#Walk
	if inputX != 0 and (!Input.is_action_pressed("Run") and !Input.is_action_pressed("RunKey")) and is_on_floor() and ctrl == 1 and CURRSTATE != "RunTurn" and CURRSTATE != "Run" and isGrounded:
		stateMachine.change_state("Walk")
	
	#Run
	if inputX != 0 and (Input.is_action_pressed("Run") or Input.is_action_pressed("RunKey")) and is_on_floor() and ctrl == 1 and CURRSTATE != "RunTurn" and isGrounded:
		stateMachine.change_state("Run")
	
	#Jump
	if bufferJump and is_on_floor() and ctrl == 1 and isGrounded:
		print("Jump buffer success")
		stateMachine.change_state("Jump")
	
	#Slide
	if is_on_floor() and abs(velocity.x) > 400 and inputY < 0 and ctrl == 1 or (is_on_floor() and inputY < 0 and ctrl == 1 and abs(get_floor_angle()) > 0.4):
		stateMachine.change_state("Slide")
	
	#Dive
	if bufferDive and ctrl == 1:
		if abs(velocity.x) < abs(diveSpeedX) or sign(velocity.x) != dir:
			velocity.x = diveSpeedX * dir
		if abs(velocity.y) < abs(diveSpeedY) or velocity.y > 0:
			velocity.y = diveSpeedY
		stateMachine.change_state("Dive")
	
	#WallSlide
	if (rayRight.is_colliding() and inputX > 0 || rayLeft.is_colliding() and inputX < 0) and !isGrounded and !is_on_floor() and velocity.y > 0 and CURRSTATE != "AirAttack" and CURRSTATE != "Damage" and CURRSTATE != "Death" and CURRSTATE != "DownAir" and !rayCeilingLeft.is_colliding() and !rayCeilingRight.is_colliding():
		stateMachine.change_state("WallSlide")
	
	#Dash Attack
	if ctrl == 1 and is_on_floor() and bufferAttack and (Input.is_action_pressed("Run") or Input.is_action_pressed("RunKey")) and isGrounded:
		stateMachine.change_state("DashAttack")
	
	#Ground Attack
	if ctrl == 1 and is_on_floor() and bufferAttack and (!Input.is_action_pressed("Run") and !Input.is_action_pressed("RunKey")):
		stateMachine.change_state("GroundAttack")
	
	#Air Attacks
	if !is_on_floor() and bufferAttack and inputY >= 0 and ctrl == 1:
		stateMachine.change_state("AirAttack")
	
	#Down Air
	if !is_on_floor() and bufferAttack and inputY < 0 and ctrl == 1:
		stateMachine.change_state("DownAir")

func _physics_process(delta):
	frameCounter += 1.0
	
	playerSprite.scale.x = abs(playerSprite.scale.x) * dir
	
	if get_node(Common.GameManagerRef).currentLevel == 4:
		print("FUCKYOU")
		hud.visible = false
	
	if attacking:
		set_collision_mask_value(9, false)
	else:
		set_collision_mask_value(9, true)
	
	if killyourselfplease.disabled == true and frameCounter > killyourselftimer + 1:
		hubris.set_collision_mask_value(9, true)
		killyourselfplease.disabled = false
	
	if velocity.y > 0 and bufferFastFall and canFastFall and velocity.y < fastFall:
		capFallSpeed = false
		velocity.y = fastFall
	
	if is_on_floor():
		var normal: Vector2 = get_floor_normal()
		playerSprite.rotation = normal.angle() + deg_to_rad(90)
		playerArea.rotation = normal.angle() + deg_to_rad(90)
		slideParticles.rotation = normal.angle( ) + deg_to_rad(90)
	else:
		if CURRSTATE != "Dive" and CURRSTATE != "Death":
			playerSprite.rotation = 0
			playerArea.rotation = 0
			
	
	if bufferJump and frameCounter > jumpBuffer + 5:
		print("Jump buffer failed")
		bufferJump = false
	
	if bufferFastFall and frameCounter > fastFallBuffer + 10:
		bufferFastFall = false
	
	if bufferDive and frameCounter > diveBuffer + 5:
		bufferDive = false
	
	if bufferAttack and frameCounter > attackBuffer + 5:
		bufferAttack = false
	
	if !is_on_floor():
		if airControl:
			airAccelStuff()
		if airPhysics:
			velocity.y += airAccelY
			if velocity.y > airSpeedY and !capFallSpeed:
				velocity.y = airSpeedY
			elif capFallSpeed and velocity.y > fastFall:
				velocity.y = fastFall
	else:
		capFallSpeed = false
		airStall = true
		divenum = 1
	
	move_and_slide()


func _on_area_2d_area_entered(area):
	if area.is_in_group("Coin"):
		coins += 1
		AudioManager.coin.play()
		area.owner.queue_free()
	if area.is_in_group("Enemy"):
		if attacking and area.owner.takeDamage:
			if velocity.x != 0:
				area.owner.DIR = sign(velocity.x)
			else:
				if area.owner.DIR > 0 and dir < 0:
					area.owner.flipEnemy()
				elif area.owner.DIR < 0 and dir > 0:
					area.owner.flipEnemy()
			area.owner.stateMachine.change_state("EnemyDeath")
		if is_on_floor():
			if attacking:
				if !area.owner.takeDamage:
					if velocity.x == 0:
						area.owner.flipEnemy()
					else:
						if sign(velocity.x) == area.owner.DIR:
							pass
						else:
							area.owner.flipEnemy()
					stateMachine.change_state("Death")
			elif !invincible:
				if velocity.x == 0:
					area.owner.flipEnemy()
				else:
					if sign(velocity.x) == area.owner.DIR:
						pass
					else:
						area.owner.flipEnemy()
				stateMachine.change_state("Death")
			else:
				pass
		else:
			if velocity.y >= 0 and !attacking and area.owner.canBounce:
				stateMachine.change_state("Air")
				stateMachine.change_state("Bounce")
				area.owner.stateMachine.change_state("EnemyDeath")
			elif attacking:
				if !area.owner.takeDamage:
					if velocity.x == 0:
						area.owner.flipEnemy()
					else:
						if sign(velocity.x) == area.owner.DIR:
							pass
						else:
							area.owner.flipEnemy()
					stateMachine.change_state("Death")
			else:
				if velocity.x == 0:
					area.owner.flipEnemy()
				else:
					if sign(velocity.x) == area.owner.DIR:
						pass
					else:
						area.owner.flipEnemy()
				stateMachine.change_state("Death")
		


func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if !body.is_in_group("Enemy"):
		if body.name == "Layer1":
			stateMachine.change_state("Death")


func _on_hubris_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if breakWalls:
		AudioManager.breakWall.play()
		body.erase_cell(body.get_coords_for_body_rid(body_rid))
	killyourselftimer = frameCounter
	killyourselfplease.disabled = true
	hubris.set_collision_mask_value(9, false)
	
