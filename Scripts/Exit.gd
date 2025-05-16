extends Node2D

@onready var canvas = $CanvasLayer
@onready var next = $CanvasLayer/Next
@onready var label = $CanvasLayer/Label
@onready var timer = $CanvasLayer/time
@onready var nextButton = $CanvasLayer/Next
@onready var retryButton = $CanvasLayer/Retry
@onready var area = $Area2D/CollisionShape2D

var wait = false
var frameCounter = 0

var focus = 0
var prevFocus = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Common.timeAttack and !get_node(Common.GameManagerRef).timeStart:
		visible = false
		area.disabled = true
	else:
		visible = true
		area.disabled = false
	
	
	if wait:
		frameCounter += 1
		
		if frameCounter == 30:
			AudioManager.finish.play()
			get_tree().paused = true
			if Common.timeAttack:
				next.visible = false
				timer.visible = true
				retryButton.grab_focus()
			else:
				nextButton.grab_focus()
			canvas.visible = true
			if Common.currentLevel == get_node(Common.GameManagerRef).currentLevel and !Common.timeAttack:
				Common.currentLevel += 1
			if !Common.noSave:
				Common.SaveData()
			print("YAY")


func _process(delta):
	if canvas.visible:
		if Common.inputY > 0 and (Common.inputYPrev == 0):
			prevFocus = focus
			focus -= 1
		if Common.inputY < 0 and (Common.inputYPrev == 0):
			prevFocus = focus
			focus += 1
	
		if focus > 2:
			prevFocus = focus
			focus = 0
		
		if focus < 0:
			prevFocus = focus
			focus = 2
		
		if focus == 0:
			$CanvasLayer/Retry.grab_focus()
			if (Input.is_action_just_pressed("Accept") or Input.is_action_just_pressed("AcceptKey")):
				$CanvasLayer/Retry.pressed.emit()
		if focus == 1:
			if next.visible:
				$CanvasLayer/Next.grab_focus()
				if (Input.is_action_just_pressed("Accept") or Input.is_action_just_pressed("AcceptKey")):
					$CanvasLayer/Next.pressed.emit()
			else:
				if prevFocus == 0:
					focus = 2
				elif prevFocus == 2:
					focus = 0
		if focus == 2:
			$CanvasLayer/Quit.grab_focus()
			if (Input.is_action_just_pressed("Accept") or Input.is_action_just_pressed("AcceptKey")):
				$CanvasLayer/Quit.pressed.emit()


func _on_area_2d_body_entered(body):
	pass


func _on_area_2d_area_entered(area):
	if area.is_in_group("Player"):
		AudioManager.end.play()
		area.owner.stateMachine.change_state("End")
		if Common.timeAttack:
			if get_node(Common.GameManagerRef).currentLevel == 0:
				if area.owner.frameCounter2 < Common.level1Time or Common.level1Time == 0:
					Common.level1Time = area.owner.frameCounter2
					Common.level1Minute = area.owner.minuteCounter
					label.text = "NEW RECORD!!!!!!"
			if get_node(Common.GameManagerRef).currentLevel == 1:
				if area.owner.frameCounter2 < Common.level2Time or Common.level2Time == 0:
					Common.level2Time = area.owner.frameCounter2
					Common.level2Minute = area.owner.minuteCounter
					label.text = "NEW RECORD!!!!!!"
			if get_node(Common.GameManagerRef).currentLevel == 2:
				if area.owner.frameCounter2 < Common.level3Time or Common.level3Time == 0:
					Common.level3Time = area.owner.frameCounter2
					Common.level3Minute = area.owner.minuteCounter
					label.text = "NEW RECORD!!!!!!"
			if get_node(Common.GameManagerRef).currentLevel == 3:
				if area.owner.frameCounter2 < Common.level4Time or Common.level4Time == 0:
					Common.level4Time = area.owner.frameCounter2
					Common.level4Minute = area.owner.minuteCounter
					label.text = "NEW RECORD!!!!!!"
			if get_node(Common.GameManagerRef).currentLevel == 4:
				if area.owner.frameCounter2 < Common.level5Time or Common.level5Time == 0:
					Common.level5Time = area.owner.frameCounter2
					Common.level5Minute = area.owner.minuteCounter
					label.text = "NEW RECORD!!!!!!"
			timer.text = "0" + str(snapped((area.owner.frameCounter2 / 60) / 60, 00)) + ":" + Common.thisIsDumbAsFuck(area.owner.minuteCounter) + str(snapped(area.owner.minuteCounter / 60, 00.01))
			Common.saveTime()
		get_node(Common.GameManagerRef).currentSong.stop()
		get_node(Common.GameManagerRef).canPause = false
		wait = true 


func _on_retry_pressed():
	canvas.visible = false
	get_node(Common.GameManagerRef).currentSong.play()
	AudioManager.finish.stop()
	get_node(Common.GameManagerRef).canPause = true
	get_node(Common.GameManagerRef).Restart()


func _on_next_pressed():
	canvas.visible = false
	AudioManager.finish.stop()
	get_node(Common.GameManagerRef).canPause = true
	get_node(Common.GameManagerRef).currentLevel = Common.currentLevel
	get_node(Common.GameManagerRef).nextLevel()
	


func _on_quit_pressed():
	get_node(Common.GameManagerRef).currentSong.stop()
	AudioManager.finish.stop()
	get_node(Common.GameManagerRef).Exit()
