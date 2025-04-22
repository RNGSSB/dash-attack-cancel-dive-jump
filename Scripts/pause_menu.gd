extends CanvasLayer


func _on_resume_pressed():
	get_parent().Resume()


func _on_restart_pressed():
	get_parent().Restart()


func _on_quit_pressed():
	AudioManager.song1.stop()
	get_parent().Exit()
