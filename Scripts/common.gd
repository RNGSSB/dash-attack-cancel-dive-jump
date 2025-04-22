extends Node

const GameManagerRef = "/root/GameManager"

const save_path = "user://game.save"

var noSave = false

var currentLevel = 0

var fuckyou = 0

@export var downButtonSprite : CompressedTexture2D
@export var rightButtonSprite : CompressedTexture2D
@export var leftButtonSprite : CompressedTexture2D
@export var upButtonSprite : CompressedTexture2D
@export var dpadUpSprite :CompressedTexture2D
@export var dpadDownSprite : CompressedTexture2D
@export var dpadLeftSprite : CompressedTexture2D
@export var dpadRightSprite : CompressedTexture2D
@export var lstickLeftSprite : CompressedTexture2D
@export var lstickRightSprite : CompressedTexture2D
@export var lstickUpSprite : CompressedTexture2D
@export var lstickDownSprite : CompressedTexture2D
@export var rstickLeftSprite : CompressedTexture2D
@export var rstickRightSprite : CompressedTexture2D
@export var rstickUpSprite : CompressedTexture2D
@export var rstickDownSprite : CompressedTexture2D
@export var rBumperSprite : CompressedTexture2D
@export var lBumperSprite : CompressedTexture2D
@export var lTriggerSprite : CompressedTexture2D
@export var rTriggerSprite : CompressedTexture2D
@export var startSprite : CompressedTexture2D
@export var selectSprite : CompressedTexture2D

@export var downButtonSprite2 : CompressedTexture2D
@export var rightButtonSprite2 : CompressedTexture2D
@export var leftButtonSprite2 : CompressedTexture2D
@export var upButtonSprite2 : CompressedTexture2D
@export var dpadUpSprite2 :CompressedTexture2D
@export var dpadDownSprite2 : CompressedTexture2D
@export var dpadLeftSprite2 : CompressedTexture2D
@export var dpadRightSprite2 : CompressedTexture2D
@export var lstickLeftSprite2 : CompressedTexture2D
@export var lstickRightSprite2 : CompressedTexture2D
@export var lstickUpSprite2 : CompressedTexture2D
@export var lstickDownSprite2 : CompressedTexture2D
@export var rstickLeftSprite2 : CompressedTexture2D
@export var rstickRightSprite2 : CompressedTexture2D
@export var rstickUpSprite2 : CompressedTexture2D
@export var rstickDownSprite2 : CompressedTexture2D
@export var rBumperSprite2 : CompressedTexture2D
@export var lBumperSprite2 : CompressedTexture2D
@export var lTriggerSprite2 : CompressedTexture2D
@export var rTriggerSprite2 : CompressedTexture2D
@export var startSprite2 : CompressedTexture2D
@export var selectSprite2 : CompressedTexture2D
@export var bigKey : CompressedTexture2D


const optionsSave = "user://options.save"


var mapList = [
preload("res://Maps/1-1.tscn"),
preload("res://Maps/1-2.tscn"),
preload("res://Maps/1-3.tscn"),
preload("res://Maps/end.tscn")
]

func _process(delta):
	#Pause and Reset
	if Input.is_action_just_pressed("FullScreen") and DisplayServer.window_get_mode() != 3 and fuckyou == 0:
		print("Fullscreen")
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	elif Input.is_action_just_pressed("FullScreen") and DisplayServer.window_get_mode() == 3 and fuckyou == 0:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	if Input.is_action_just_pressed("FullScreen") and DisplayServer.window_get_mode() == 3 and fuckyou == 1:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED) 
	elif Input.is_action_just_pressed("FullScreen") and DisplayServer.window_get_mode() != 3 and fuckyou == 1:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN) 
	if Input.is_action_just_released("FullScreen"):
		if fuckyou == 0:
			fuckyou = 1
		else:
			fuckyou = 0

func SaveData():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(currentLevel)

func LoadData():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		currentLevel = file.get_var(currentLevel)
	else:
		currentLevel = -1
		print("No data found, dumbass")
