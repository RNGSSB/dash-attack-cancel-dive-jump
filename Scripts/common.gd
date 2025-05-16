extends Node

const GameManagerRef = "/root/GameManager"

const save_path = "user://game.save"

var noSave = false

var timeAttack = false

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

var explosion = preload("res://particleexplosion.tscn")


var mapList = [
preload("res://Maps/1-1.tscn"),
preload("res://Maps/1-2.tscn"),
preload("res://Maps/1-3.tscn"),
preload("res://Maps/end.tscn")
]

const timeAttackSave = "user://timeattack.save"

var savedTimes = [Vector2(0,0),Vector2(0,0),Vector2(0,0),Vector2(0,0),Vector2(0,0)]

var level1Time = 0
var level1Minute = 0
var level2Time = 0
var level2Minute = 0
var level3Time = 0
var level3Minute = 0
var level4Time = 0
var level4Minute = 0
var level5Time = 0
var level5Minute = 0
var inputX = 0
var inputY = 0
var inputYPrev = 0
var inputXPrev = 0

var inputYFailSafe = false
var inputYTimer = 0

var frameCounter = 0


func saveTime():
	var file = FileAccess.open(timeAttackSave, FileAccess.WRITE)
	file.store_var(level1Time)
	file.store_var(level1Minute)
	file.store_var(level2Time)
	file.store_var(level2Minute)
	file.store_var(level3Time)
	file.store_var(level3Minute)
	file.store_var(level4Time)
	file.store_var(level4Minute)
	file.store_var(level5Time)
	file.store_var(level5Minute)

func loadTime():
	if FileAccess.file_exists(timeAttackSave):
		var file = FileAccess.open(timeAttackSave, FileAccess.READ)
		level1Time = file.get_var(level1Time)
		level1Minute = file.get_var(level1Minute)
		level2Time = file.get_var(level2Time)
		level2Minute = file.get_var(level2Minute)
		level3Time = file.get_var(level3Time)
		level3Minute = file.get_var(level3Minute)
		level4Time = file.get_var(level4Time)
		level4Minute = file.get_var(level4Minute)
		level5Time = file.get_var(level5Time)
		level5Minute = file.get_var(level5Minute)
	else:
		level1Time = 0
		level1Minute = 0
		level2Time = 0
		level2Minute = 0
		level3Time = 0
		level3Minute = 0
		level4Time = 0
		level4Minute = 0
		level5Time = 0
		level5Minute = 0

func thisIsDumbAsFuck(total):
	if total < 600.0:
		return "0"
	else:
		return ""

func _process(delta):
	var controllerX = Input.get_axis("Left", "Right")
	var controllerY = Input.get_axis("Down", "Up")	
	
	var keyX = Input.get_axis("LeftKey", "RightKey")
	var keyY = Input.get_axis("DownKey", "UpKey")	
	
	if controllerX != 0 and keyX != 0:
		if controllerX != keyX:
			inputXPrev = inputX
			inputX = 0
		else:
			inputXPrev = inputX
			inputX = controllerX
	elif controllerX != 0 and keyX == 0:
		inputXPrev = inputX
		inputX = controllerX
	elif controllerX == 0 and keyX != 0:
		inputXPrev = inputX
		inputX = keyX
	elif controllerX == 0 and keyX == 0:
		inputXPrev = inputX
		inputX = 0
	
	if controllerY != 0 and keyY != 0:
		if controllerY != keyY:
			inputYPrev = inputY
			inputY = 0
		else:
			inputYPrev = inputY
			inputY = controllerY
	elif controllerY != 0 and keyY == 0:
		inputYPrev = inputY
		inputY = controllerY
	elif controllerY == 0 and keyY != 0:
		inputYPrev = inputY
		inputY = keyY
	elif controllerY == 0 and keyY == 0:
		inputYPrev = inputY
		inputY = 0
	
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

func _physics_process(delta):
	frameCounter += 1
	
	if inputY != 0 and inputYPrev == 0 and !inputYFailSafe:
		inputYTimer = frameCounter
		inputYFailSafe = true
	
	if inputYFailSafe and frameCounter > inputYTimer + 40:
		inputYFailSafe = false

func SaveData():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(currentLevel)

func returnSavedLevel():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		return file.get_var(currentLevel)
	else:
		return 1

func LoadData():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		currentLevel = file.get_var(currentLevel)
	else:
		currentLevel = 1
		print("No data found, dumbass")
