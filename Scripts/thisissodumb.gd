extends CanvasLayer

@export var controller : VBoxContainer
@export var keyboard : VBoxContainer
@onready var button1 = $PanelContainer/VBoxContainer/InputMapper/Controller/Up

var focusX = 0
var focusY = 0
var canPress = false
var setting = false


func _process(delta):
	if visible:
		if Input.is_action_just_pressed("Return") or Input.is_action_just_pressed("ReturnKey"):
			$PanelContainer/VBoxContainer/Return.pressed.emit()
		
		if (Input.is_action_just_released("Accept") or Input.is_action_just_released("AcceptKey")):
			canPress = true
		
		if !setting:
			if Common.inputY > 0 and (Common.inputYPrev == 0):
				focusY -= 1
			if Common.inputY < 0 and (Common.inputYPrev == 0):
				focusY += 1
		
			if focusY > 11:
				focusY = 0
			
			if focusY < 0:
				focusY = 11
			
			if Common.inputX > 0 and (Common.inputXPrev == 0):
				focusX -= 1
			if Common.inputX < 0 and (Common.inputXPrev == 0):
				focusX += 1
		
			if focusX > 1:
				focusX = 0
			
			if focusX < 0:
				focusX = 1
		
		print(setting)
		
		if focusX == 0 and focusY < 10:
			if focusY == 0:
				$PanelContainer/VBoxContainer/InputMapper/Controller/Up.grab_focus()
				if (Input.is_action_just_pressed("Accept") or Input.is_action_just_pressed("AcceptKey")) and canPress:
					setting = true
					$PanelContainer/VBoxContainer/InputMapper/Controller/Up.pressed.emit()
			if focusY == 1:
				$PanelContainer/VBoxContainer/InputMapper/Controller/Down.grab_focus()
				if (Input.is_action_just_pressed("Accept") or Input.is_action_just_pressed("AcceptKey")) and canPress:
					setting = true
					$PanelContainer/VBoxContainer/InputMapper/Controller/Up.pressed.emit()
			if focusY == 2:
				$PanelContainer/VBoxContainer/InputMapper/Controller/Left.grab_focus()
				if (Input.is_action_just_pressed("Accept") or Input.is_action_just_pressed("AcceptKey")) and canPress:
					setting = true
					$PanelContainer/VBoxContainer/InputMapper/Controller/Up.pressed.emit()
			if focusY == 3:
				$PanelContainer/VBoxContainer/InputMapper/Controller/Right.grab_focus()
				if (Input.is_action_just_pressed("Accept") or Input.is_action_just_pressed("AcceptKey")) and canPress:
					setting = true
					$PanelContainer/VBoxContainer/InputMapper/Controller/Up.pressed.emit()
			if focusY == 4:
				$PanelContainer/VBoxContainer/InputMapper/Controller/Jump.grab_focus()
				if (Input.is_action_just_pressed("Accept") or Input.is_action_just_pressed("AcceptKey")) and canPress:
					setting = true
					$PanelContainer/VBoxContainer/InputMapper/Controller/Up.pressed.emit()
			if focusY == 5:
				$PanelContainer/VBoxContainer/InputMapper/Controller/Attack.grab_focus()
				if (Input.is_action_just_pressed("Accept") or Input.is_action_just_pressed("AcceptKey")) and canPress:
					setting = true
					$PanelContainer/VBoxContainer/InputMapper/Controller/Up.pressed.emit()
			if focusY == 6:
				$PanelContainer/VBoxContainer/InputMapper/Controller/Run.grab_focus()
				if (Input.is_action_just_pressed("Accept") or Input.is_action_just_pressed("AcceptKey")) and canPress:
					setting = true
					$PanelContainer/VBoxContainer/InputMapper/Controller/Up.pressed.emit()
			if focusY == 7:
				$PanelContainer/VBoxContainer/InputMapper/Controller/Dive.grab_focus()
				if (Input.is_action_just_pressed("Accept") or Input.is_action_just_pressed("AcceptKey")) and canPress:
					setting = true
					$PanelContainer/VBoxContainer/InputMapper/Controller/Up.pressed.emit()
			if focusY == 8:
				$PanelContainer/VBoxContainer/InputMapper/Controller/Start.grab_focus()
				if (Input.is_action_just_pressed("Accept") or Input.is_action_just_pressed("AcceptKey")) and canPress:
					setting = true
					$PanelContainer/VBoxContainer/InputMapper/Controller/Up.pressed.emit()
			if focusY == 9:
				$PanelContainer/VBoxContainer/InputMapper/Controller/Select.grab_focus()
				if (Input.is_action_just_pressed("Accept") or Input.is_action_just_pressed("AcceptKey")) and canPress:
					setting = true
					$PanelContainer/VBoxContainer/InputMapper/Controller/Up.pressed.emit()
		elif focusX == 1 and focusY < 10:
			if focusY == 0:
				$PanelContainer/VBoxContainer/InputMapper/Keyboard/Up.grab_focus()
				if (Input.is_action_just_pressed("Accept") or Input.is_action_just_pressed("AcceptKey")) and canPress:
					setting = true
					$PanelContainer/VBoxContainer/InputMapper/Keyboard/Up.pressed.emit()
			if focusY == 1:
				$PanelContainer/VBoxContainer/InputMapper/Keyboard/Down.grab_focus()
				if (Input.is_action_just_pressed("Accept") or Input.is_action_just_pressed("AcceptKey")) and canPress:
					setting = true
					$PanelContainer/VBoxContainer/InputMapper/Keyboard/Up.pressed.emit()
			if focusY == 2:
				$PanelContainer/VBoxContainer/InputMapper/Keyboard/Left.grab_focus()
				if (Input.is_action_just_pressed("Accept") or Input.is_action_just_pressed("AcceptKey")) and canPress:
					setting = true
					$PanelContainer/VBoxContainer/InputMapper/Keyboard/Up.pressed.emit()
			if focusY == 3:
				$PanelContainer/VBoxContainer/InputMapper/Keyboard/Right.grab_focus()
				if (Input.is_action_just_pressed("Accept") or Input.is_action_just_pressed("AcceptKey")) and canPress:
					setting = true
					$PanelContainer/VBoxContainer/InputMapper/Keyboard/Up.pressed.emit()
			if focusY == 4:
				$PanelContainer/VBoxContainer/InputMapper/Keyboard/Jump.grab_focus()
				if (Input.is_action_just_pressed("Accept") or Input.is_action_just_pressed("AcceptKey")) and canPress:
					setting = true
					$PanelContainer/VBoxContainer/InputMapper/Keyboard/Up.pressed.emit()
			if focusY == 5:
				$PanelContainer/VBoxContainer/InputMapper/Keyboard/Attack.grab_focus()
				if (Input.is_action_just_pressed("Accept") or Input.is_action_just_pressed("AcceptKey")) and canPress:
					setting = true
					$PanelContainer/VBoxContainer/InputMapper/Keyboard/Up.pressed.emit()
			if focusY == 6:
				$PanelContainer/VBoxContainer/InputMapper/Keyboard/Run.grab_focus()
				if (Input.is_action_just_pressed("Accept") or Input.is_action_just_pressed("AcceptKey")) and canPress:
					setting = true
					$PanelContainer/VBoxContainer/InputMapper/Keyboard/Up.pressed.emit()
			if focusY == 7:
				$PanelContainer/VBoxContainer/InputMapper/Keyboard/Dive.grab_focus()
				if (Input.is_action_just_pressed("Accept") or Input.is_action_just_pressed("AcceptKey")) and canPress:
					setting = true
					$PanelContainer/VBoxContainer/InputMapper/Keyboard/Up.pressed.emit()
			if focusY == 8:
				$PanelContainer/VBoxContainer/InputMapper/Keyboard/Start.grab_focus()
				if (Input.is_action_just_pressed("Accept") or Input.is_action_just_pressed("AcceptKey")) and canPress:
					setting = true
					$PanelContainer/VBoxContainer/InputMapper/Keyboard/Up.pressed.emit()
			if focusY == 9:
				$PanelContainer/VBoxContainer/InputMapper/Keyboard/Select.grab_focus()
				if (Input.is_action_just_pressed("Accept") or Input.is_action_just_pressed("AcceptKey")) and canPress:
					setting = true
					$PanelContainer/VBoxContainer/InputMapper/Keyboard/Up.pressed.emit()
		elif focusY >= 10:
			if focusY == 10:
				$PanelContainer/VBoxContainer/Default.grab_focus()
				if (Input.is_action_just_pressed("Accept") or Input.is_action_just_pressed("AcceptKey")) and canPress:
					$PanelContainer/VBoxContainer/Default.pressed.emit()
			if focusY == 11:
				$PanelContainer/VBoxContainer/Return.grab_focus()
				if (Input.is_action_just_pressed("Accept") or Input.is_action_just_pressed("AcceptKey")) and canPress:
					$PanelContainer/VBoxContainer/Return.pressed.emit()


func _on_return_pressed():
	visible = false
	canPress = false
	owner.OptionsMenu.visible = true


func _on_default_pressed():
	InputMap.load_from_project_settings()
	controller.reloadBind()
	keyboard.reloadBind()
	
