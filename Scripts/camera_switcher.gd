extends Node2D


@export var cameraLimitLeft = -10000000
@export var cameraLimitTop = -10000000
@export var cameraLimitRight = 10000000
@export var cameraLimitBottom = 10000000

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_area_entered(area):
	if area.is_in_group("Player"):
		get_node(Common.GameManagerRef).setCameraLimits(cameraLimitLeft, cameraLimitTop, cameraLimitRight, cameraLimitBottom)
