extends StaticBody2D
@export var lane_index: int = 0

var current_customer = null
var customer_queue: Array = []

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
	
func get_drink_path_follow() -> PathFollow2D:
	return get_node_or_null("DrinkPath/DrinkPathFollow")
	
func get_queue_point_global_position() -> Vector2:
	var customer_zone = get_node_or_null("Customer Zone")
	
	if customer_zone == null:
		return global_position
		
	var queue_point = customer_zone.get_node_or_null("QueuePoint1")
	
	if queue_point == null:
		return get_stop_point_global_position()
		
	return queue_point.global_position

func add_customer_to_queue(customer) -> Vector2:
	customer_queue.append(customer)
	
	if customer_queue.size() == 1:
		current_customer = customer
		return get_stop_point_global_position()
		
	return get_queue_point_global_position()
	
func get_front_customer():
	if customer_queue.is_empty():
		return null
	return customer_queue[0]
	
func serve_front_customer() -> void:
	var front_customer = get_front_customer()
	
	if front_customer == null:
		return
		
	front_customer.serve_customer()
	customer_queue.erase(front_customer)
	
	current_customer = get_front_customer()
