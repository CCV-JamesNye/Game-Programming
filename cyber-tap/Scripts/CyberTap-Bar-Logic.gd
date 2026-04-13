extends Node2D
var lives := 3

@onready var bartender__player_: CharacterBody2D = $"Bartender (Player)"
@onready var life_1: Sprite2D = $HealthBar/HBoxContainer/Life1
@onready var life_2: Sprite2D = $HealthBar/HBoxContainer/Life2
@onready var life_3: Sprite2D = $HealthBar/HBoxContainer/Life3
@onready var pause_menu: CanvasLayer = $PauseMenu
@onready var resume_game: Button = $PauseMenu/Panel/VBoxContainer/ResumeGame
@onready var quit_game: Button = $PauseMenu/Panel/VBoxContainer/QuitGame

func _ready() -> void:
	bartender__player_.glass_broke.connect(_on_glass_broke)
	update_lives_ui()
	resume_game.pressed.connect(_on_resume_pressed)
	quit_game.pressed.connect(_on_quit_pressed)
	pause_menu.visible = false
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		toggle_pause()

func toggle_pause() -> void:
	get_tree().paused = not get_tree().paused
	pause_menu.visible = get_tree().paused
	
func _on_resume_pressed() -> void:
	get_tree().paused = false
	pause_menu.visible = false
	
func _on_quit_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
func _on_glass_broke() -> void:
	lives -= 1
	update_lives_ui()
	
	if lives <= 0:
		get_tree().change_scene_to_file("res://Scenes/game_over.tscn")
		
func update_lives_ui() -> void:
	life_1.visible = lives >= 1
	life_2.visible = lives >= 2
	life_3.visible = lives >= 3
