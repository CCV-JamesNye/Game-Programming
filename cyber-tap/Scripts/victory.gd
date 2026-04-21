extends Control

@onready var main_menu: Button = $VBoxContainer/MainMenu
@onready var quit_game: Button = $VBoxContainer/QuitGame

func _ready() -> void:
	main_menu.pressed.connect(_on_main_menu_pressed)
	quit_game.pressed.connect(_on_quit_game_pressed)
	
func _on_main_menu_pressed() -> void:
	SceneManager.go_to_main_menu()
	
func _on_quit_game_pressed() -> void:
	get_tree().quit()
