extends StaticBody2D
@export var lane_index: int = 0

var current_customer = null

func _on_customer_zone_body_entered(body: Node2D) -> void:
	if body.name == "Customer":
		current_customer = body
func _on_customer_zone_body_exited(body: Node2D) -> void:
	if body == current_customer:
		current_customer = null

func get_stop_point_global_position() -> Vector2:
	var customer_zone = get_node_or_null("Customer Zone")
	
	if customer_zone == null:
		return global_position
		
	for child in customer_zone.get_children():
		if child is Marker2D:
			return child.global_position
			
	return global_position
func get_serve_start_global_position() -> Vector2:
	for child in get_children():
		if child is Marker2D and child.name.begins_with("ServeStartPoint"):
			return child.global_position
	return global_position
