extends Area2D

@export var lane_index : int = 0

func _on_body_entered(body):
	if body.name == "Bartender (Player)":
		print("Bartender entered lane:", lane_index)
		body.current_lane = get_parent()

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Bartender (Player)":
		print("Bartender exited lane:", lane_index)
		
		if body.current_lane == get_parent():
			body.current_lane = null
