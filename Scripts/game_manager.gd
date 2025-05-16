extends Node2D

@export var PLAYER : PackedScene
@export var LEVEL : PackedScene
@export var HUD : PackedScene
@export var CAMERA : PackedScene

@export var SPAWNPOINT : Vector2

var cameraLimitLeft = -10000000
var cameraLimitTop = -10000000
var cameraLimitRight = 10000000
var cameraLimitBottom = 10000000

var currentTotalFrames = 0
var currentMinuteFrames = 0

var checkTotalFrames1 = 0
var checkMinuteFrames1 = 0

var checkTotalFrames2 = 0
var checkMinuteFrames2 = 0

var checkTotalFrames3 = 0
var checkMinuteFrames3 = 0

var pausecheck = 0
var fuckyou = 0

var currentLevel = 0

var currentCheck = 0
var checkpoint1 
var checkpoint2
var checkpoint3

var controllerType = 0
var currentCoins = 0
var canPause = true

var currentSong 

var isPaused = false 

var timeStart = false



func saveTime(num, total, minute, coins):
	if num == 1:
		checkTotalFrames1 = total
		checkMinuteFrames1 = minute
		currentCoins = coins
	if num == 2:
		checkTotalFrames2 = total
		checkMinuteFrames2 = minute
		currentCoins = coins
	if num == 3:
		checkTotalFrames3 = total
		checkMinuteFrames3 = minute
		currentCoins = coins


func timeAttackSave(total, minute):
	Common.savedTimes[currentLevel] = Vector2(total, minute)

func setCameraLimits(left, top, right, bottom):
	cameraLimitLeft = left
	cameraLimitTop = top
	cameraLimitRight = right
	cameraLimitBottom = bottom


func spawnPlayer(position):
	if currentLevel == 3:
		return
	var playerInstance = PLAYER.instantiate()
	var cameraInstance = CAMERA.instantiate()
	playerInstance.position = position
	playerInstance.frameCounter2 = currentTotalFrames
	playerInstance.minuteCounter = currentMinuteFrames
	playerInstance.coins = currentCoins
	cameraInstance.position = position
	add_child(playerInstance)
	add_child(cameraInstance)
	

func hardCodedSongsYouAreSoCoolPearl():
	if currentLevel == 0:
		currentSong = AudioManager.song1
	if currentLevel == 1:
		currentSong = AudioManager.song2
	if currentLevel == 2:
		currentSong = AudioManager.song3
	if currentLevel == 3:
		currentSong = AudioManager.coin
	if currentLevel == 4:
		currentSong = AudioManager.song2
	if currentLevel == 5:
		currentSong = AudioManager.song3
	if currentLevel == 6:
		currentSong = AudioManager.song1
	if currentLevel == 7:
		currentSong = AudioManager.song2
	if currentLevel == 8:
		currentSong = AudioManager.song3

# Called when the node enters the scene tree for the first time.
func _ready():
	currentLevel = Common.currentLevel
	hardCodedSongsYouAreSoCoolPearl()
	currentSong.play()
	var newInstance = Common.mapList[currentLevel].instantiate()
	var pauseInstance = HUD.instantiate()
	cameraLimitLeft = newInstance.cameraLimitLeft
	cameraLimitTop = newInstance.cameraLimitTop
	cameraLimitRight = newInstance.cameraLimitRight
	cameraLimitBottom = newInstance.cameraLimitBottom
	currentTotalFrames = 0
	currentMinuteFrames = 0
	pauseInstance.visible = false
	pausecheck = 0
	fuckyou = 0
	add_child(newInstance)
	add_child(pauseInstance)
	

func _unhandled_input(event):
	if event.is_pressed():
		if event is InputEventJoypadButton and event.button_index != 7 and event.button_index != 8 or event is InputEventJoypadMotion:
			controllerType = 0
		elif event is InputEventKey:
			controllerType = 1

func Resume():
	pausecheck = 0
	isPaused = false
	get_tree().paused = false

func nextLevel():
	for n in get_children():
		print("removing " + n.name)
		remove_child(n)
		n.queue_free()
	hardCodedSongsYouAreSoCoolPearl()
	currentSong.play()
	currentCheck = 0
	currentLevel = Common.currentLevel
	currentCoins = 0
	var newInstance = Common.mapList[currentLevel].instantiate()
	var pauseInstance = HUD.instantiate()
	cameraLimitLeft = newInstance.cameraLimitLeft
	cameraLimitTop = newInstance.cameraLimitTop
	cameraLimitRight = newInstance.cameraLimitRight
	cameraLimitBottom = newInstance.cameraLimitBottom
	currentTotalFrames = 0
	currentMinuteFrames = 0
	pauseInstance.visible = false
	add_child(newInstance)
	add_child(pauseInstance)
	get_tree().paused = false

func Respawn():
	if Common.timeAttack:
		timeStart = false
	for n in get_children():
		print("removing " + n.name)
		remove_child(n)
		n.queue_free()
	var newInstance = Common.mapList[currentLevel].instantiate()
	var pauseInstance = HUD.instantiate()
	cameraLimitLeft = newInstance.cameraLimitLeft
	cameraLimitTop = newInstance.cameraLimitTop
	cameraLimitRight = newInstance.cameraLimitRight
	cameraLimitBottom = newInstance.cameraLimitBottom
	pauseInstance.visible = false
	pausecheck = 0
	add_child(newInstance)
	add_child(pauseInstance)
	get_tree().paused = false


func Restart():
	if Common.timeAttack:
		timeStart = false
	for n in get_children():
		print("removing " + n.name)
		remove_child(n)
		n.queue_free()
	var newInstance = Common.mapList[currentLevel].instantiate()
	var pauseInstance = HUD.instantiate()
	currentCoins = 0
	cameraLimitLeft = newInstance.cameraLimitLeft
	cameraLimitTop = newInstance.cameraLimitTop
	cameraLimitRight = newInstance.cameraLimitRight
	cameraLimitBottom = newInstance.cameraLimitBottom
	currentTotalFrames = 0
	currentMinuteFrames = 0
	currentCheck = 0
	pauseInstance.visible = false
	pausecheck = 0
	isPaused = false
	AudioManager.reset.play()
	add_child(newInstance)
	add_child(pauseInstance)
	get_tree().paused = false

func Exit():
	currentSong.stop()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Objects/main_menu.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var pauseChild = $PauseMenu
	
	checkpoint1 = get_node("Map/Checkpoint")
	
	checkpoint2 = get_node("Map/Checkpoint2")
	
	checkpoint3 = get_node("Map/Checkpoint3")
	
	if checkpoint1.passed and currentCheck <= checkpoint1.checkPointNum:
		currentMinuteFrames = checkMinuteFrames1
		currentTotalFrames = checkTotalFrames1
		currentCheck = 1
	
	if checkpoint2.passed and currentCheck <= checkpoint2.checkPointNum:
		checkpoint1.passCheckpoint()
		currentMinuteFrames = checkMinuteFrames2
		currentTotalFrames = checkTotalFrames2
		currentCheck = 2
	
	if checkpoint3.passed and currentCheck <= checkpoint3.checkPointNum:
		checkpoint1.passCheckpoint()
		checkpoint2.passCheckpoint()
		currentMinuteFrames = checkMinuteFrames3
		currentTotalFrames = checkTotalFrames3
		currentCheck = 3
	
	if OS.has_feature("editor"):
		if Input.is_key_pressed(KEY_2) and canPause:
			currentCheck = 1
			Respawn()
	
		if Input.is_key_pressed(KEY_3) and canPause:
			currentCheck = 2
			Respawn()
	
		if Input.is_key_pressed(KEY_4) and canPause:
			currentCheck = 3
			Respawn()
	
	pauseChild.visible = isPaused
	
	if canPause:
		if (Input.is_action_just_pressed("Start") or Input.is_action_just_pressed("StartKey")) and pausecheck == 0:
			isPaused = true
			pauseChild.resumeButton.grab_focus()
			get_tree().paused = true
		if (Input.is_action_just_pressed("Start") or Input.is_action_just_pressed("StartKey")) and pausecheck == 1:
			isPaused = false
			pauseChild.focus = 0
			pauseChild.OptionsMenu.focus = 0
			pauseChild.OptionsMenu.canPress = false
			pauseChild.OptionsMenu.visible = false
			get_tree().paused = false
		if (Input.is_action_just_released("Start") or Input.is_action_just_released("StartKey")):
			if pausecheck == 0:
				pausecheck = 1
			else:
				pausecheck = 0
		
	if (Input.is_action_just_pressed("Select") or Input.is_action_just_pressed("SelectKey")) and canPause and Common.timeAttack:
		Restart()
