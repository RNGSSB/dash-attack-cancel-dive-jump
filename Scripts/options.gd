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


func _on_return_pressed():
	SaveData()
	visible = false
	owner.visible = true


func _on_controls_pressed():
	owner.InputMapper.visible = true
	visible = false


func _on_volume_slider_value_changed(value):
	masterVolume = value
	AudioServer.set_bus_volume_db(0, value)


func _on_mute_toggled(toggled_on):
	print("WTF is going on")
	mute = toggled_on
	AudioServer.set_bus_mute(0, toggled_on)


func _on_fullscreen_toggled(toggled_on):
	fullscreen = toggled_on
	if DisplayServer.window_get_mode() != 3:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN) 
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED) 


func _on_music_slider_value_changed(value):
	musicVolume = value
	AudioServer.set_bus_volume_db(2, value)


func _on_sfx_slider_value_changed(value):
	sfxVolume = value
	AudioServer.set_bus_volume_db(1, value)
