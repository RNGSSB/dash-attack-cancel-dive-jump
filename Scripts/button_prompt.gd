extends Node2D

@export var action : String
@onready var sprite = $Sprite2D
@onready var sprite2 = $Sprite2D2
@onready var label = $Label

# Called when the node enters the scene tree for the first time.
func _ready():
	
	if InputMap.action_get_events(action + "Key")[0].as_text() == "Shift" or InputMap.action_get_events(action + "Key")[0].as_text() == "Space":
		sprite2.texture = Common.bigKey
	
	
	label.text = InputMap.action_get_events(action + "Key")[0].as_text()
	
	if InputMap.action_get_events(action)[0].as_text() == "Joypad Button 11 (D-pad Up)":
		sprite.texture = Common.dpadUpSprite2
	elif InputMap.action_get_events(action)[0].as_text() == "Joypad Button 12 (D-pad Down)":
		sprite.texture = Common.dpadDownSprite2
	elif InputMap.action_get_events(action)[0].as_text() == "Joypad Button 13 (D-pad Left)":
		sprite.texture = Common.dpadLeftSprite2
	elif InputMap.action_get_events(action)[0].as_text() == "Joypad Button 14 (D-pad Right)":
		sprite.texture = Common.dpadRightSprite2
	elif InputMap.action_get_events(action)[0].as_text() == "Joypad Button 2 (Left Action, Sony Square, Xbox X, Nintendo Y)":
		sprite.texture = Common.leftButtonSprite2
	elif InputMap.action_get_events(action)[0].as_text() == "Joypad Button 0 (Bottom Action, Sony Cross, Xbox A, Nintendo B)":
		sprite.texture = Common.downButtonSprite2
	elif InputMap.action_get_events(action)[0].as_text() == "Joypad Button 1 (Right Action, Sony Circle, Xbox B, Nintendo A)":
		sprite.texture = Common.rightButtonSprite2
	elif InputMap.action_get_events(action)[0].as_text() == "Joypad Button 3 (Top Action, Sony Triangle, Xbox Y, Nintendo X)":
		sprite.texture = Common.upButtonSprite2
	elif InputMap.action_get_events(action)[0].as_text() == "Joypad Button 9 (Left Shoulder, Sony L1, Xbox LB)":
		sprite.texture = Common.lBumperSprite2
	elif InputMap.action_get_events(action)[0].as_text() == "Joypad Button 10 (Right Shoulder, Sony R1, Xbox RB)":
		sprite.texture = Common.rBumperSprite2
	elif InputMap.action_get_events(action)[0].as_text() == "Joypad Button 4 (Back, Sony Select, Xbox Back, Nintendo -)":
		sprite.texture = Common.selectSprite2
	elif InputMap.action_get_events(action)[0].as_text() == "Joypad Button 6 (Start, Xbox Menu, Nintendo +)":
		sprite.texture = Common.startSprite2
	elif InputMap.action_get_events(action)[0] is InputEventJoypadMotion:
		if InputMap.action_get_events(action)[0].axis == 1 and InputMap.action_get_events(action)[0].axis_value > 0:
			sprite.texture = Common.lstickDownSprite2
		elif InputMap.action_get_events(action)[0].axis == 1 and InputMap.action_get_events(action)[0].axis_value < 0:
			sprite.texture = Common.lstickUpSprite2
		elif InputMap.action_get_events(action)[0].axis == 0 and InputMap.action_get_events(action)[0].axis_value > 0:
			sprite.texture = Common.lstickRightSprite2
		elif InputMap.action_get_events(action)[0].axis == 0 and InputMap.action_get_events(action)[0].axis_value < 0:
			sprite.texture = Common.lstickLeftSprite2
		elif InputMap.action_get_events(action)[0].axis == 2 and InputMap.action_get_events(action)[0].axis_value > 0:
			sprite.texture = Common.rstickRightSprite2
		elif  InputMap.action_get_events(action)[0].axis == 2 and InputMap.action_get_events(action)[0].axis_value < 0:
			sprite.texture = Common.rstickLeftSprite2
		elif InputMap.action_get_events(action)[0].axis == 3 and InputMap.action_get_events(action)[0].axis_value > 0:
			sprite.texture = Common.rstickDownSprite2
		elif InputMap.action_get_events(action)[0].axis == 3 and InputMap.action_get_events(action)[0].axis_value < 0:
			sprite.texture = Common.rstickUpSprite2
		elif InputMap.action_get_events(action)[0].axis == 4 and InputMap.action_get_events(action)[0].axis_value > 0:
			sprite.texture = Common.lTriggerSprite2
		elif InputMap.action_get_events(action)[0].axis == 5 and InputMap.action_get_events(action)[0].axis_value > 0:
			sprite.texture = Common.rTriggerSprite2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_node(Common.GameManagerRef).controllerType == 0:
		sprite.visible = true
		sprite2.visible = false
		label.visible = false
	else:
		sprite.visible = false
		sprite2.visible = true
		label.visible = true
