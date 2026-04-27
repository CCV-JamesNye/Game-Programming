extends Node2D

@export var level_name: String = "Level 1"
@export var customers_to_win: int = 5

var customers_served := 0
var lives := 3
var camera_shake_enabled :=true

@onready var bartender__player_: CharacterBody2D = $"Bartender (Player)"
@onready var life_1: Sprite2D = $HealthBar/HBoxContainer/Life1
@onready var life_2: Sprite2D = $HealthBar/HBoxContainer/Life2
@onready var life_3: Sprite2D = $HealthBar/HBoxContainer/Life3
@onready var pause_menu: CanvasLayer = $PauseMenu
@onready var resume_game: Button = $PauseMenu/Panel/VBoxContainer/ResumeGame
@onready var quit_game: Button = $PauseMenu/Panel/VBoxContainer/QuitGame
@onready var toggle_shake: Button = $PauseMenu/ToggleShake
@onready var level_progress_label: Label = $HealthBar/LevelProgressLabel
@onready var music_volume_slider: HSlider = $PauseMenu/MusicVolumeSlider
@onready var tutorial_text: Label = get_node_or_null("TutorialText")



func _ready() -> void:
	bartender__player_.glass_broke.connect(_on_glass_broke)
	update_lives_ui()
	resume_game.pressed.connect(_on_resume_pressed)
	quit_game.pressed.connect(_on_quit_pressed)
	pause_menu.visible = false
	toggle_shake.pressed.connect(_on_toggle_shake_pressed)
	update_shake_button_text()
	update_level_progress_ui()
	music_volume_slider.value = SceneManager.get_music_volume()
	music_volume_slider.value_changed.connect(_on_music_volume_changed)
	
	if tutorial_text != null:
		tutorial_text.visible = true
		await get_tree().create_timer(10.0).timeout
		tutorial_text.visible = false

func _on_music_volume_changed(value: float) -> void:
	SceneManager.set_music_volume(value)
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		toggle_pause()

func _on_toggle_shake_pressed() -> void:
	camera_shake_enabled = not camera_shake_enabled
	update_shake_button_text()
	
func update_shake_button_text() -> void:
	if camera_shake_enabled:
		toggle_shake.text = "Camera Shake: On"
	else:
		toggle_shake.text = "Camera Shake: Off"
func toggle_pause() -> void:
	get_tree().paused = not get_tree().paused
	pause_menu.visible = get_tree().paused
	
func _on_resume_pressed() -> void:
	get_tree().paused = false
	pause_menu.visible = false
	
func _on_quit_pressed() -> void:
	get_tree().paused = false
	SceneManager.go_to_main_menu()

func _on_glass_broke() -> void:
	lives -= 1
	update_lives_ui()
	
	if lives <= 0:
		get_tree().change_scene_to_file("res://Scenes/game_over.tscn")
		
func update_lives_ui() -> void:
	life_1.visible = lives >= 1
	life_2.visible = lives >= 2
	life_3.visible = lives >= 3

func register_customer_served() -> void:
	customers_served += 1
	update_level_progress_ui()
	print("Customers served:", customers_served, "/", customers_to_win)
	
	if customers_served >= customers_to_win:
		SceneManager.go_to_next_level()

func update_level_progress_ui() -> void:
	level_progress_label.text = level_name + " Served: " + str(customers_served) + " / " + str(customers_to_win)
