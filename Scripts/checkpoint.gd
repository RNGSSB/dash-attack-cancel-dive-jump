extends Node2D


@onready var animator = $AnimationPlayer
@onready var area = $Area2D/CollisionShape2D

@export var checkPointNum = 1

var passed = false


# Called when the node enters the scene tree for the first time.
func _ready():
	if Common.timeAttack:
		visible = false
		area.disabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func passCheckpoint():
	animator.play("PASSED")
	passed = true


func _on_area_2d_area_entered(area):
	if area.is_in_group("Player"):
		if passed == false: 
			get_node(Common.GameManagerRef).saveTime(checkPointNum, area.owner.frameCounter2, area.owner.minuteCounter, area.owner.coins)
			AudioManager.checkpoint.play()
			passCheckpoint()
			print("GOTTEM!")
