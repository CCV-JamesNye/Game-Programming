extends Control

@onready var try_again: Button = $VBoxContainer/TryAgain
@onready var quit_game: Button = $VBoxContainer/QuitGame

func _ready() -> void:
	try_again.pressed.connect(_on_retry_pressed)
	quit_game.pressed.connect(_on_menu_pressed)
	
func _on_retry_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/CyberTapBar.tscn")
	
func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
