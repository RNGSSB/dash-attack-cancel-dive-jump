extends Node2D

@onready var area = $Area2D/CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
	if Common.timeAttack:
		visible = true
		area.disabled = false
	else:
		visible = false
		area.disabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_area_entered(area):
	if !get_node(Common.GameManagerRef).timeStart:
		AudioManager.checkpoint.play()
	get_node(Common.GameManagerRef).timeStart = true
