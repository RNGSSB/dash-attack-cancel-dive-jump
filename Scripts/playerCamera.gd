extends Camera2D


var player


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	player = get_node("/root/GameManager/Player")
	
	limit_bottom = get_node(Common.GameManagerRef).cameraLimitBottom
	limit_top = get_node(Common.GameManagerRef).cameraLimitTop
	limit_left = get_node(Common.GameManagerRef).cameraLimitLeft
	limit_right = get_node(Common.GameManagerRef).cameraLimitRight
	
	if get_node(Common.GameManagerRef).currentLevel != 4:
		position.x = player.position.x
		if player.CURRSTATE != "Death":
			position.y = player.position.y -50
	
