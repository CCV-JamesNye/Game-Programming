extends Control

@onready var start: Button = $MarginContainer/VBoxContainer/Start
@onready var quit: Button = $MarginContainer/VBoxContainer/Quit

func _ready() -> void:
	start.pressed.connect(_on_start_pressed)
	quit.pressed.connect(_on_quit_pressed)
	
func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/CyberTapBar.tscn")
	
func _on_quit_pressed() -> void:
	get_tree().quit()
