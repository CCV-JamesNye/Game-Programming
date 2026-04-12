extends StaticBody2D
@export var lane_index: int = 0

var current_customer = null

func _on_customer_zone_body_entered(body: Node2D) -> void:
	if body.name == "Customer":
		current_customer = body
func _on_customer_zone_body_exited(body: Node2D) -> void:
	if body == current_customer:
		current_customer = null
