extends Node2D


@onready var spawn = $PlayerSpawn
@onready var checkPoint1 = $Checkpoint
@onready var checkPoint2 = $Checkpoint2
@onready var checkPoint3 = $Checkpoint3

@export var cameraLimitLeft = -10000000
@export var cameraLimitTop = -10000000
@export var cameraLimitRight = 10000000
@export var cameraLimitBottom = 10000000



# Called when the node enters the scene tree for the first time.
func _ready():
	if get_node(Common.GameManagerRef).currentCheck == 0:
		get_node(Common.GameManagerRef).spawnPlayer(spawn.position)
	if get_node(Common.GameManagerRef).currentCheck == 1:
		get_node(Common.GameManagerRef).spawnPlayer(checkPoint1.position)
	if get_node(Common.GameManagerRef).currentCheck == 2:
		get_node(Common.GameManagerRef).spawnPlayer(checkPoint2.position)
	if get_node(Common.GameManagerRef).currentCheck == 3:
		get_node(Common.GameManagerRef).spawnPlayer(checkPoint3.position)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
