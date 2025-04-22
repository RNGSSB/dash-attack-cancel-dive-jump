extends Node2D


@onready var animator = $AnimationPlayer

@export var checkPointNum = 1

var passed = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func passCheckpoint():
	animator.play("PASSED")
	passed = true


func _on_area_2d_area_entered(area):
	if area.is_in_group("Player"):
		if passed == false: 
			get_node(Common.GameManagerRef).saveTime(checkPointNum, area.owner.frameCounter, area.owner.minuteCounter, area.owner.coins)
			AudioManager.checkpoint.play()
			passCheckpoint()
			print("GOTTEM!")
