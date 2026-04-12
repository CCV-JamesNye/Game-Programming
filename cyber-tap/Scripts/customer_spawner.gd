extends Node2D
#holds reference to customer scene

@export var customer_scene: PackedScene	
var stop_points = []
@export var min_spawn_delay: float = 1.0
@export var max_spawn_delay: float = 3.0
var current_customer = null

func _ready() -> void:
	stop_points = [
		$"../Lane1/Customer Zone/StopPoint",
		$"../Lane2/Customer Zone/StopPoint2",
		$"../Lane3/Customer Zone/StopPoint3",
		$"../Lane4/Customer Zone/StopPoint4"
]
	spawn_customer()
	

func spawn_customer() -> void:
	current_customer = customer_scene.instantiate()
	add_child(current_customer)
	current_customer.global_position = global_position
	var chosen_stop_point = stop_points.pick_random()
	current_customer.stop_point = chosen_stop_point
	print("Chosen stop point:", chosen_stop_point.global_position)

func spawn_after_delay() -> void:
	var delay = randf_range(min_spawn_delay, max_spawn_delay)
	await get_tree().create_timer(delay).timeout
	spawn_customer()
