extends Control

@onready var try_again: Button = $VBoxContainer/TryAgain
@onready var quit_game: Button = $VBoxContainer/QuitGame

func _ready() -> void:
	try_again.pressed.connect(_on_retry_pressed)
	quit_game.pressed.connect(_on_menu_pressed)
	
func _on_retry_pressed() -> void:
	SceneManager.restart_level()
	
func _on_menu_pressed() -> void:
	SceneManager.go_to_main_menu()
