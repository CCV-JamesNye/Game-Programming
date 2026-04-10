extends Area2D
@export var lane_index: int = 0

var current_customer = null

func _on_customer_zone_body_entered(body: Node2D) -> void:
	if body.name == "Customer":
		body.current_lane = self

func _on_customer_zone_body_exited(body: Node2D) -> void:
	if body == current_customer:
		body.current_lane = null
