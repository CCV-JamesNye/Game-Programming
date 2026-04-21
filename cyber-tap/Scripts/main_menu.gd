extends Control

@onready var start: Button = $MarginContainer/VBoxContainer/Start
@onready var quit: Button = $MarginContainer/VBoxContainer/Quit
@onready var music_volume_slider: HSlider = $MusicVolumeSlider

func _ready() -> void:
	start.pressed.connect(_on_start_pressed)
	quit.pressed.connect(_on_quit_pressed)
	music_volume_slider.value = SceneManager.get_music_volume()
	music_volume_slider.value_changed.connect(_on_music_volume_changed)
	
func _on_start_pressed() -> void:
	SceneManager.start_game()

func _on_quit_pressed() -> void:
	get_tree().quit()
	
func _on_music_volume_changed(value: float) -> void:
	SceneManager.set_music_volume(value)
