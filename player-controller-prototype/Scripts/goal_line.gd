extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		call_deferred("_go_to_victory")
	pass # Replace with function body.

func _go_to_victory():
	get_tree().change_scene_to_file("res://Scenes/UI/victory_screen.tscn")
