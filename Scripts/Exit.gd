extends Node2D

@onready var canvas = $CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	pass


func _on_area_2d_area_entered(area):
	if area.is_in_group("Player"):
		get_node(Common.GameManagerRef).currentSong.stop()
		get_node(Common.GameManagerRef).canPause = false
		AudioManager.finish.play()
		get_tree().paused = true
		canvas.visible = true
		if Common.currentLevel == get_node(Common.GameManagerRef).currentLevel:
			Common.currentLevel += 1
		if !Common.noSave:
			Common.SaveData()
		print("YAY")


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
