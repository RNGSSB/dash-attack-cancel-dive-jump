extends Button

@export var action : String
@onready var input_mapper = $".."

func _init():
	toggle_mode = true

func _ready():
	set_process_unhandled_input(false)

func _toggled(button_pressed):
	set_process_unhandled_input(button_pressed)
	if button_pressed:
		text = "...Waiting"
		icon = null
	else:
		update_text()

func _unhandled_input(event):
	if event.is_pressed():
		if event is InputEventJoypadButton and event.button_index != 7 and event.button_index != 8 or event is InputEventJoypadMotion:
			print(event)
			InputMap.action_erase_events(action)
			InputMap.action_add_event(action, event)
			button_pressed = false
			release_focus()
			update_text()
			input_mapper.keymaps[action] = event
			input_mapper.save_keymap()

func update_text():
	if InputMap.action_get_events(action)[0].as_text() == "Joypad Button 11 (D-pad Up)":
		icon = Common.dpadUpSprite
	elif InputMap.action_get_events(action)[0].as_text() == "Joypad Button 12 (D-pad Down)":
		icon = Common.dpadDownSprite
	elif InputMap.action_get_events(action)[0].as_text() == "Joypad Button 13 (D-pad Left)":
		icon = Common.dpadLeftSprite
	elif InputMap.action_get_events(action)[0].as_text() == "Joypad Button 14 (D-pad Right)":
		icon = Common.dpadRightSprite
	elif InputMap.action_get_events(action)[0].as_text() == "Joypad Button 2 (Left Action, Sony Square, Xbox X, Nintendo Y)":
		icon = Common.leftButtonSprite
	elif InputMap.action_get_events(action)[0].as_text() == "Joypad Button 0 (Bottom Action, Sony Cross, Xbox A, Nintendo B)":
		icon = Common.downButtonSprite
	elif InputMap.action_get_events(action)[0].as_text() == "Joypad Button 1 (Right Action, Sony Circle, Xbox B, Nintendo A)":
		icon = Common.rightButtonSprite
	elif InputMap.action_get_events(action)[0].as_text() == "Joypad Button 3 (Top Action, Sony Triangle, Xbox Y, Nintendo X)":
		icon = Common.upButtonSprite
	elif InputMap.action_get_events(action)[0].as_text() == "Joypad Button 9 (Left Shoulder, Sony L1, Xbox LB)":
		icon = Common.lBumperSprite
	elif InputMap.action_get_events(action)[0].as_text() == "Joypad Button 10 (Right Shoulder, Sony R1, Xbox RB)":
		icon = Common.rBumperSprite
	elif InputMap.action_get_events(action)[0].as_text() == "Joypad Button 4 (Back, Sony Select, Xbox Back, Nintendo -)":
		icon = Common.selectSprite
	elif InputMap.action_get_events(action)[0].as_text() == "Joypad Button 6 (Start, Xbox Menu, Nintendo +)":
		icon = Common.startSprite
	elif InputMap.action_get_events(action)[0] is InputEventJoypadMotion:
		if InputMap.action_get_events(action)[0].axis == 1 and InputMap.action_get_events(action)[0].axis_value > 0:
			icon = Common.lstickDownSprite
		elif InputMap.action_get_events(action)[0].axis == 1 and InputMap.action_get_events(action)[0].axis_value < 0:
			icon = Common.lstickUpSprite
		elif InputMap.action_get_events(action)[0].axis == 0 and InputMap.action_get_events(action)[0].axis_value > 0:
			icon = Common.lstickRightSprite
		elif InputMap.action_get_events(action)[0].axis == 0 and InputMap.action_get_events(action)[0].axis_value < 0:
			icon = Common.lstickLeftSprite
		elif InputMap.action_get_events(action)[0].axis == 2 and InputMap.action_get_events(action)[0].axis_value > 0:
			icon = Common.rstickRightSprite
		elif  InputMap.action_get_events(action)[0].axis == 2 and InputMap.action_get_events(action)[0].axis_value < 0:
			icon = Common.rstickLeftSprite
		elif InputMap.action_get_events(action)[0].axis == 3 and InputMap.action_get_events(action)[0].axis_value > 0:
			icon = Common.rstickDownSprite
		elif InputMap.action_get_events(action)[0].axis == 3 and InputMap.action_get_events(action)[0].axis_value < 0:
			icon = Common.rstickUpSprite
		elif InputMap.action_get_events(action)[0].axis == 4 and InputMap.action_get_events(action)[0].axis_value > 0:
			icon = Common.lTriggerSprite
		elif InputMap.action_get_events(action)[0].axis == 5 and InputMap.action_get_events(action)[0].axis_value > 0:
			icon = Common.rTriggerSprite
	
	text = ""
