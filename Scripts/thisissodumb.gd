extends CanvasLayer

@export var controller : VBoxContainer
@export var keyboard : VBoxContainer


func _on_return_pressed():
	visible = false
	owner.OptionsMenu.visible = true


func _on_default_pressed():
	InputMap.load_from_project_settings()
	controller.reloadBind()
	keyboard.reloadBind()
	
