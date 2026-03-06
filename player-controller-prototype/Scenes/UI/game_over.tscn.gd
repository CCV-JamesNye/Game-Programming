extends CanvasLayer

@onready var menu_button_defy_extinction_: Button = $"Control/MarginContainer/VBoxContainer/MenuButton(Defy-Extinction)"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	menu_button_defy_extinction_.pressed.connect( _menu )
	pass # Replace with function body.


func _menu () -> void:
	await SceneTransition.fade_to_black()
	get_tree().change_scene_to_file("res://Scenes/UI/MainMenu.tscn")
