extends CanvasLayer


@onready var OptionsMenu = $Options
@onready var InputMapper = $InputMapper
@onready var optionsButton = $PanelContainer/VBoxContainer/Options
@onready var resumeButton = $PanelContainer/VBoxContainer/Resume

var focus = 0

func _process(delta):
	if visible:
		if Input.is_action_just_pressed("Return"):
			$PanelContainer/VBoxContainer/Resume.pressed.emit()
		
		if Common.inputY > 0 and (Common.inputYPrev == 0):
			focus -= 1
		if Common.inputY < 0 and (Common.inputYPrev == 0):
			focus += 1
	
		if focus > 3:
			focus = 0
		
		if focus < 0:
			focus = 3
		
		if focus == 0:
			$PanelContainer/VBoxContainer/Resume.grab_focus()
			if (Input.is_action_just_pressed("Accept") or Input.is_action_just_pressed("AcceptKey")):
				$PanelContainer/VBoxContainer/Resume.pressed.emit()
		if focus == 1:
			$PanelContainer/VBoxContainer/Restart.grab_focus()
			if (Input.is_action_just_pressed("Accept") or Input.is_action_just_pressed("AcceptKey")):
				$PanelContainer/VBoxContainer/Restart.pressed.emit()
		if focus == 2:
			$PanelContainer/VBoxContainer/Options.grab_focus()
			if (Input.is_action_just_pressed("Accept") or Input.is_action_just_pressed("AcceptKey")):
				$PanelContainer/VBoxContainer/Options.pressed.emit()
		if focus == 3:
			$PanelContainer/VBoxContainer/Quit.grab_focus()
			if (Input.is_action_just_pressed("Accept") or Input.is_action_just_pressed("AcceptKey")):
				$PanelContainer/VBoxContainer/Quit.pressed.emit()


func _on_resume_pressed():
	get_parent().Resume()


func _on_restart_pressed():
	get_parent().Restart()


func _on_quit_pressed():
	AudioManager.song1.stop()
	get_parent().Exit()


func _on_options_pressed():
	visible = false
	get_node(Common.GameManagerRef).isPaused = false
	OptionsMenu.visible = true
