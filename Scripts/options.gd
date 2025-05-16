extends CanvasLayer


const optionsSave = "user://options.save"

var masterVolume = 0
var musicVolume = 0
var sfxVolume = 0
var fullscreen = false
var mute = false

@export var fullCheck : CheckBox
@export var muteCheck : CheckBox
@export var masterSlider : HSlider
@export var musicSlider : HSlider
@export var sfxSlider : HSlider
@onready var controlButton = $PanelContainer/VBoxContainer/Controls

var lol = false

var lol2 = false

var focus = 0

var canPress = false
# Called when the node enters the scene tree for the first time.
func _ready():
	LoadData()
	muteCheck.button_pressed = mute
	fullCheck.button_pressed = fullscreen
	masterSlider.value = masterVolume
	musicSlider.value = musicVolume
	sfxSlider.value = sfxVolume
	
	AudioServer.set_bus_volume_db(0, masterVolume)
	AudioServer.set_bus_volume_db(1, sfxVolume)
	AudioServer.set_bus_volume_db(2, musicVolume)
	AudioServer.set_bus_mute(0, mute)
	if fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN) 
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED) 

func SaveData():
	var file = FileAccess.open(optionsSave, FileAccess.WRITE)
	file.store_var(masterVolume)
	file.store_var(musicVolume)
	file.store_var(sfxVolume)
	file.store_var(fullscreen)
	file.store_var(mute)

func LoadData():
	if FileAccess.file_exists(optionsSave):
		var file = FileAccess.open(optionsSave, FileAccess.READ)
		masterVolume = file.get_var(masterVolume)
		musicVolume = file.get_var(musicVolume)
		sfxVolume = file.get_var(sfxVolume)
		fullscreen = file.get_var(fullscreen)
		mute = file.get_var(mute)
	else:
		masterVolume = 0
		musicVolume = 0
		sfxVolume = 0
		fullscreen = false
		mute = false
		print("No data found, dumbass")


func _process(delta):
	if visible:
		if Input.is_action_just_pressed("Return") or Input.is_action_just_pressed("ReturnKey"):
			$PanelContainer/VBoxContainer/Return.pressed.emit()
		
		if (Input.is_action_just_released("Accept") or Input.is_action_just_released("AcceptKey")):
			canPress = true
		
		if Common.inputY > 0 and (Common.inputYPrev == 0):
			focus -= 1
		if Common.inputY < 0 and (Common.inputYPrev == 0):
			focus += 1
	
		if focus > 6:
			focus = 0
		
		if focus < 0:
			focus = 6
		
		if focus == 0:
			$PanelContainer/VBoxContainer/Fullscreen.grab_focus()
			if (Input.is_action_just_pressed("Accept") or Input.is_action_just_pressed("AcceptKey")) and canPress:
				if fullCheck.button_pressed == true:
					fullCheck.button_pressed = false
				else:
					fullCheck.button_pressed = true
		if focus == 1:
			$PanelContainer/VBoxContainer/Mute.grab_focus()
			if (Input.is_action_just_pressed("Accept") or Input.is_action_just_pressed("AcceptKey")) and canPress:
				if muteCheck.button_pressed == true:
					muteCheck.button_pressed = false
				else:
					muteCheck.button_pressed = true
		if focus == 2:
			$PanelContainer/VBoxContainer/VolumeSlider.grab_focus()
			if Common.inputX != 0 and Common.inputXPrev == 0:
				$PanelContainer/VBoxContainer/VolumeSlider.value += 1.0 * sign(Common.inputX)
		if focus == 3:
			$PanelContainer/VBoxContainer/MusicSlider.grab_focus()
			if Common.inputX != 0 and Common.inputXPrev == 0:
				$PanelContainer/VBoxContainer/MusicSlider.value += 1.0 * sign(Common.inputX)
		if focus == 4:
			$PanelContainer/VBoxContainer/SFXSlider.grab_focus()
			if Common.inputX != 0 and Common.inputXPrev == 0:
				$PanelContainer/VBoxContainer/SFXSlider.value += 1.0 * sign(Common.inputX)
		if focus == 5:
			$PanelContainer/VBoxContainer/Controls.grab_focus()
			if (Input.is_action_just_pressed("Accept") or Input.is_action_just_pressed("AcceptKey")) and canPress:
				$PanelContainer/VBoxContainer/Controls.pressed.emit()
		if focus == 6:
			$PanelContainer/VBoxContainer/Return.grab_focus()
			if (Input.is_action_just_pressed("Accept") or Input.is_action_just_pressed("AcceptKey")) and canPress:
				$PanelContainer/VBoxContainer/Return.pressed.emit()

func _on_return_pressed():
	SaveData()
	visible = false
	canPress = false
	if get_node(Common.GameManagerRef) != null:
		get_node(Common.GameManagerRef).isPaused = true
	owner.visible = true


func _on_controls_pressed():
	owner.InputMapper.visible = true
	owner.InputMapper.button1.grab_focus()
	visible = false


func _on_volume_slider_value_changed(value):
	masterVolume = value
	AudioServer.set_bus_volume_db(0, value)


func _on_mute_toggled(toggled_on):
	print("WTF is going on")
	mute = toggled_on
	AudioServer.set_bus_mute(0, toggled_on)


func _on_fullscreen_toggled(toggled_on):
	if lol:
		fullscreen = toggled_on
		if DisplayServer.window_get_mode() != 3:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN) 
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED) 
	lol = true


func _on_music_slider_value_changed(value):
	musicVolume = value
	AudioServer.set_bus_volume_db(2, value)


func _on_sfx_slider_value_changed(value):
	sfxVolume = value
	AudioServer.set_bus_volume_db(1, value)
	if lol2:
		AudioManager.coin.play()
	lol2 = true
