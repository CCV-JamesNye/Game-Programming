extends Node2D
#holds reference to customer scene

@export var customer_scene: PackedScene
@export var customer_textures: Array[Texture2D] = []
var stop_points = []
var lanes = []
var customer_layers = []
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
	
	customer_layers = [
		$"../Lane1CustomerLayer",
		$"../Lane2CustomerLayer",
		$"../Lane3CustomerLayer",
		$"../Lane4CustomerLayer"
	]
	
	start_spawning()
	

func spawn_customer() -> void:
	var chosen_lane_index = randi_range(0, lanes.size() -1)
	var chosen_lane = lanes[chosen_lane_index]
	var chosen_customer_layer = customer_layers[chosen_lane_index]
	
	current_customer = customer_scene.instantiate()
	chosen_customer_layer.add_child(current_customer)
	
	if not customer_textures.is_empty():
		var sprite: Sprite2D = current_customer.get_node("Sprite2D")
		sprite.texture = customer_textures.pick_random()
		
	current_customer.global_position = global_position
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
		await get_tree().create_timer(delay, false).timeout
