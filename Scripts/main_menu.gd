extends Control

@export var levelCounter : Label
@onready var InputMapper = $InputMapper
@onready var OptionsMenu = $Options

func _ready():
	print("FUCK")
	AudioManager.menu.play()
	Common.LoadData()
	if Common.currentLevel >= 0:
		levelCounter.text = "Current Level: " + str(Common.currentLevel + 1)
	else:
		levelCounter.text = "Current Level: 0"
	

func _on_quit_game_pressed():
	get_tree().quit()


func _on_options_pressed():
	visible = false
	OptionsMenu.visible = true


func _on_load_game_pressed():
	AudioManager.menu.stop()
	Common.LoadData()
	if Common.currentLevel >= 0:
		get_tree().change_scene_to_file("res://game_manager.tscn")


func _on_new_game_pressed():
	print("LOL")
	AudioManager.menu.stop()
	Common.currentLevel = 0
	Common.noSave = false
	get_tree().change_scene_to_file("res://game_manager.tscn")


func _on_no_save_pressed():
	AudioManager.menu.stop()
	Common.currentLevel = 0
	Common.noSave = true
	get_tree().change_scene_to_file("res://game_manager.tscn")


func _on_delete_data_pressed():
	Common.currentLevel = 0
	Common.SaveData()
	levelCounter.text = "Current Level: " + str(Common.currentLevel + 1)
