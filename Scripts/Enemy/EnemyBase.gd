extends CharacterBody2D

@export var enemySprite : Sprite2D
@export var enemyAnimation : AnimationPlayer
@export var enemyCollision : CollisionShape2D
@export var enemyHitbox : CollisionShape2D
@export var raycastLeft : RayCast2D
@export var raycastRight : RayCast2D

@onready var enemyArea2D = $Area2D
@onready var stateMachine = $StateMachine


@export var GRAVITY = 15
@export var SPEED = 70
@export var DIR = 1
@export var KICKTIME = 2
@export var KICKSPEED = 300

@export var WALKOFF = true

@export var PREVSTATE = "EnemyIdle"
@export var CURRSTATE = "EnemyIdle"

var stateFrame = 0
var frameCounter = 0

@export var takeDamage = true
@export var canBounce = true

func _ready():
	enemyArea2D.add_to_group("Enemy")
	add_to_group("Enemy")
	frameCounter = 0

func flipEnemy():
	print("loasfsfajgvbsjkahfujks")
	DIR = DIR * -1
	

func _physics_process(delta):
	frameCounter += 1
	enemySprite.scale.x = abs(enemySprite.scale.x) * DIR
	move_and_slide()


func _on_area_2d_area_entered(area):
	pass # Replace with function body.
