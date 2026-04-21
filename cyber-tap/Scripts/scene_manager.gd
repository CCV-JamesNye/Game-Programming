extends Node

var current_level_index := 0

var levels := [
	"res://Scenes/CyberTap_level_1.tscn",
	"res://Scenes/CyberTap_level_2.tscn",
	"res://Scenes/CyberTap_level_3.tscn"
]

var victory_scene := "res://Scenes/victory.tscn"
var main_menu_scene := "res://Scenes/main_menu.tscn"

func start_game() -> void:
	current_level_index = 0
	get_tree().change_scene_to_file(levels[current_level_index])
	
func go_to_next_level() -> void:
	current_level_index += 1
	
	if current_level_index < levels.size():
		get_tree().change_scene_to_file(levels[current_level_index])
	else:
		get_tree().change_scene_to_file(victory_scene)
		
func restart_level() -> void:
	get_tree().change_scene_to_file(levels[current_level_index])
	
func go_to_main_menu() -> void:
	get_tree().change_scene_to_file(main_menu_scene)
	
func set_music_volume(value: float) -> void:
	var music_bus_index = AudioServer.get_bus_index("Music")
	
	if music_bus_index == -1:
		return
		
	if value <= 0.0:
		AudioServer.set_bus_mute(music_bus_index, true)
	else:
		AudioServer.set_bus_mute(music_bus_index, false)
		AudioServer.set_bus_volume_db(music_bus_index, linear_to_db(value))
		
func get_music_volume() -> float:
	var music_bus_index = AudioServer.get_bus_index("Music")
	
	if music_bus_index == -1:
		return 1.0
		
	if AudioServer.is_bus_mute(music_bus_index):
		return 0.0
		
	return db_to_linear(AudioServer.get_bus_volume_db(music_bus_index))
