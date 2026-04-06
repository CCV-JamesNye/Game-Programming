extends Area2D

@export var lane_index : int = 0

func _on_body_entered(body):
	if body is CharacterBody2D:
		print("Bartender entered lane:", lane_index)
		body.current_lane = lane_index

func _on_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		print("Bartender exited lane:", lane_index)
		body.current_lane = null
