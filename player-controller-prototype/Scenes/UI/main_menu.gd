extends Control

@onready var start_button: Button = $MarginContainer/Panel/MarginContainer/VBoxContainer/StartButton
@onready var quit_button: Button = $MarginContainer/Panel/MarginContainer/VBoxContainer/QuitButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_button.pressed.connect ( _start_game )
	quit_button.pressed.connect ( _quit_game )
	await SceneTransition.fade_in()
	pass # Replace with function body.

func _quit_game () -> void:
	get_tree().quit()
	
func _start_game () -> void:
	await SceneTransition.fade_to_black()
	get_tree().change_scene_to_file("res://Scenes/Skater_Scroller.tscn")
	pass
	
	
