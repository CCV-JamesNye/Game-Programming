extends Node2D
#holds reference to customer scene

@export var customer_scene: PackedScene	
var stop_points = []
var lanes = []
@export var min_spawn_delay: float = 1.0
@export var max_spawn_delay: float = 3.0
var current_customer = null
var spawning_enabled := true


func _ready() -> void:
	stop_points = [
		$"../Lane1/Customer Zone/StopPoint",
		$"../Lane2/Customer Zone/StopPoint2",
		$"../Lane3/Customer Zone/StopPoint3",
		$"../Lane4/Customer Zone/StopPoint4"
	]
	
	lanes = [
		$"../Lane1",
		$"../Lane2",
		$"../Lane3",
		$"../Lane4"
	]
	
	start_spawning()
	

func spawn_customer() -> void:
	current_customer = customer_scene.instantiate()
	add_child(current_customer)
	current_customer.global_position = global_position
	
	var chosen_lane = lanes.pick_random()
	var target_position = chosen_lane.add_customer_to_queue(current_customer)
	
	current_customer.target_position = target_position
	current_customer.global_position.y = target_position.y
	current_customer.stop_point = chosen_lane
	print("Chosen lane:", chosen_lane.name, " target:", target_position)

func spawn_after_delay() -> void:
	pass
	
func start_spawning() -> void:
	while spawning_enabled:
		spawn_customer()
		var delay = randf_range(min_spawn_delay, max_spawn_delay)
		await get_tree().create_timer(delay).timeout
