extends Control

@export var levelCounter : Label
@onready var InputMapper = $InputMapper
@onready var OptionsMenu = $Options
@onready var TimeAttack = $TimeAttack
@onready var button1 = $PanelContainer/VBoxContainer/NoSave
@onready var optionsButton = $PanelContainer/VBoxContainer/Options
@onready var timeAttackButton = $PanelContainer/VBoxContainer/TimeAttack

var focus = 0

func _ready():
	print("FUCK")
	AudioManager.menu.play()
	Common.LoadData()
	if Common.currentLevel >= 0:
		levelCounter.text = "Current Level: " + str(Common.returnSavedLevel() + 1)
	else:
		levelCounter.text = "Current Level: 0"

func _process(delta):
	if visible:
		if Common.inputY > 0 and (Common.inputYPrev == 0):
			focus -= 1
		if Common.inputY < 0 and (Common.inputYPrev == 0):
			focus += 1
	
		if focus > 6:
			focus = 0
		
		if focus < 0:
			focus = 6
		if focus == 0:
			$PanelContainer/VBoxContainer/NoSave.grab_focus()
			if (Input.is_action_just_pressed("Accept") or Input.is_action_just_pressed("AcceptKey")):
				$PanelContainer/VBoxContainer/NoSave.pressed.emit()
		if focus == 1:
			$PanelContainer/VBoxContainer/NewGame.grab_focus()
			if (Input.is_action_just_pressed("Accept") or Input.is_action_just_pressed("AcceptKey")):
				$PanelContainer/VBoxContainer/NewGame.pressed.emit()
		if focus == 2:
			$PanelContainer/VBoxContainer/LoadGame.grab_focus()
			if (Input.is_action_just_pressed("Accept") or Input.is_action_just_pressed("AcceptKey")):
				$PanelContainer/VBoxContainer/LoadGame.pressed.emit()
		if focus == 3:
			$PanelContainer/VBoxContainer/TimeAttack.grab_focus()
			if (Input.is_action_just_pressed("Accept") or Input.is_action_just_pressed("AcceptKey")):
				$PanelContainer/VBoxContainer/TimeAttack.pressed.emit()
		if focus == 4:
			$PanelContainer/VBoxContainer/DeleteData.grab_focus()
			if (Input.is_action_just_pressed("Accept") or Input.is_action_just_pressed("AcceptKey")):
				$PanelContainer/VBoxContainer/DeleteData.pressed.emit()
		if focus == 5:
			$PanelContainer/VBoxContainer/Options.grab_focus()
			if (Input.is_action_just_pressed("Accept") or Input.is_action_just_pressed("AcceptKey")):
				$PanelContainer/VBoxContainer/Options.pressed.emit()
		if focus == 6:
			$PanelContainer/VBoxContainer/QuitGame.grab_focus()
			if (Input.is_action_just_pressed("Accept") or Input.is_action_just_pressed("AcceptKey")):
				$PanelContainer/VBoxContainer/QuitGame.pressed.emit()

func _on_quit_game_pressed():
	get_tree().quit()


func _on_options_pressed():
	visible = false
	OptionsMenu.visible = true


func timeAttack(id):
	AudioManager.menu.stop()
	Common.currentLevel = id
	Common.noSave = false
	Common.timeAttack = true
	get_tree().change_scene_to_file("res://game_manager.tscn")


func _on_load_game_pressed():
	AudioManager.menu.stop()
	Common.LoadData()
	Common.timeAttack = false
	if Common.currentLevel >= 0:
		get_tree().change_scene_to_file("res://game_manager.tscn")


func _on_new_game_pressed():
	print("LOL")
	AudioManager.menu.stop()
	Common.currentLevel = 0
	Common.noSave = false
	Common.timeAttack = false
	get_tree().change_scene_to_file("res://game_manager.tscn")


func _on_no_save_pressed():
	AudioManager.menu.stop()
	Common.currentLevel = 0
	Common.noSave = true
	Common.timeAttack = false
	get_tree().change_scene_to_file("res://game_manager.tscn")


func _on_delete_data_pressed():
	Common.currentLevel = 0
	Common.level1Minute = 0
	Common.level1Time = 0
	Common.level2Minute = 0
	Common.level2Time = 0
	Common.level3Minute = 0
	Common.level3Time = 0
	Common.level4Minute = 0
	Common.level4Time = 0
	Common.level5Minute = 0
	Common.level5Time = 0
	Common.SaveData()
	Common.saveTime()
	Common.loadTime()
	levelCounter.text = "Current Level: " + str(Common.currentLevel + 1)


func _on_time_attack_pressed():
	visible = false
	TimeAttack.timeText()
	TimeAttack.backButton.grab_focus()
	TimeAttack.visible = true
