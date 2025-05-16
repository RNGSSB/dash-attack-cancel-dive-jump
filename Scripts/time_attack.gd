extends CanvasLayer

@onready var label1 = $"PanelContainer/VBoxContainer/HBoxContainer/VBoxContainer2/1-1"
@onready var label2 = $"PanelContainer/VBoxContainer/HBoxContainer/VBoxContainer2/1-2"
@onready var label3 = $"PanelContainer/VBoxContainer/HBoxContainer/VBoxContainer2/1-3"
@onready var label4 = $"PanelContainer/VBoxContainer/HBoxContainer/VBoxContainer2/1-4"
@onready var label5 = $"PanelContainer/VBoxContainer/HBoxContainer/VBoxContainer2/1-5"
@onready var backButton = $PanelContainer/VBoxContainer/HBoxContainer/return

var focusX = 0
var focusY = 0

var canPress = false

func _ready():
	Common.loadTime()
	timeText()


func _process(delta):
	if visible:
		if Input.is_action_just_pressed("Return") or Input.is_action_just_pressed("ReturnKey"):
			$PanelContainer/VBoxContainer/HBoxContainer/return.pressed.emit()
		
		if (Input.is_action_just_released("Accept") or Input.is_action_just_released("AcceptKey")):
			canPress = true
		
		if Common.inputY > 0 and (Common.inputYPrev == 0):
			focusY -= 1
		if Common.inputY < 0 and (Common.inputYPrev == 0):
			focusY += 1
	
		if focusY > 4:
			focusY = 0
		
		if focusY < 0:
			focusY = 4
		
		if Common.inputX > 0 and (Common.inputXPrev == 0):
			focusX -= 1
		if Common.inputX < 0 and (Common.inputXPrev == 0):
			focusX += 1
	
		if focusX > 1:
			focusX = 0
		
		if focusX < 0:
			focusX = 1
		
		if focusX == 0:
			$PanelContainer/VBoxContainer/HBoxContainer/return.grab_focus()
			if (Input.is_action_just_pressed("Accept") or Input.is_action_just_pressed("AcceptKey")) and canPress:
				$PanelContainer/VBoxContainer/HBoxContainer/return.pressed.emit()
		elif focusX == 1:
			if focusY == 0:
				$PanelContainer/VBoxContainer/HBoxContainer/VBoxContainer/Level1.grab_focus()
				if (Input.is_action_just_pressed("Accept") or Input.is_action_just_pressed("AcceptKey")) and canPress:
					$PanelContainer/VBoxContainer/HBoxContainer/VBoxContainer/Level1.pressed.emit()
			if focusY == 1:
				$PanelContainer/VBoxContainer/HBoxContainer/VBoxContainer/Level2.grab_focus()
				if (Input.is_action_just_pressed("Accept") or Input.is_action_just_pressed("AcceptKey")) and canPress:
					$PanelContainer/VBoxContainer/HBoxContainer/VBoxContainer/Level2.pressed.emit()
			if focusY == 2:
				$PanelContainer/VBoxContainer/HBoxContainer/VBoxContainer/Level3.grab_focus()
				if (Input.is_action_just_pressed("Accept") or Input.is_action_just_pressed("AcceptKey")) and canPress:
					$PanelContainer/VBoxContainer/HBoxContainer/VBoxContainer/Level3.pressed.emit()
			if focusY == 3:
				$PanelContainer/VBoxContainer/HBoxContainer/VBoxContainer/Level4.grab_focus()
				if (Input.is_action_just_pressed("Accept") or Input.is_action_just_pressed("AcceptKey")) and canPress:
					pass
			if focusY == 4:
				$PanelContainer/VBoxContainer/HBoxContainer/VBoxContainer/Level5.grab_focus()
				if (Input.is_action_just_pressed("Accept") or Input.is_action_just_pressed("AcceptKey")) and canPress:
					pass

func timeText():
	label1.text = "0" + str(snapped((Common.level1Time / 60) / 60, 00)) + ":" + Common.thisIsDumbAsFuck(Common.level1Minute) + str(snapped(Common.level1Minute / 60, 00.01))
	label2.text = "0" + str(snapped((Common.level2Time / 60) / 60, 00)) + ":" + Common.thisIsDumbAsFuck(Common.level2Minute) + str(snapped(Common.level2Minute / 60, 00.01))
	label3.text = "0" + str(snapped((Common.level3Time / 60) / 60, 00)) + ":" + Common.thisIsDumbAsFuck(Common.level3Minute) + str(snapped(Common.level3Minute / 60, 00.01))
	label4.text = "0" + str(snapped((Common.level4Time / 60) / 60, 00)) + ":" + Common.thisIsDumbAsFuck(Common.level4Minute) + str(snapped(Common.level4Minute / 60, 00.01))
	label5.text = "0" + str(snapped((Common.level5Time / 60) / 60, 00)) + ":" + Common.thisIsDumbAsFuck(Common.level5Minute) + str(snapped(Common.level5Minute / 60, 00.01))

func _on_return_pressed():
	visible = false
	canPress = false
	owner.visible = true


func _on_level_1_pressed():
	owner.timeAttack(0)


func _on_level_2_pressed():
	owner.timeAttack(1)


func _on_level_3_pressed():
	owner.timeAttack(2)


func _on_level_4_pressed():
	owner.timeAttack(3)


func _on_level_5_pressed():
	owner.timeAttack(3)
