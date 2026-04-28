extends Area2D

signal arrived(drink, lane)

@export var speed: float = 250.0

var lane = null
var target_position: Vector2
var moving:= false
var path_follow: PathFollow2D = null 
var path_progress := 0.0

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	
func _on_body_entered(body: Node) -> void:
	if lane == null:
		return
		
	if not body.has_method("serve_customer"):
		return
		
	if body != lane.get_front_customer():
		return
		
	moving = false
	lane.call_deferred("serve_customer_in_lane", body)
	
	if get_parent().has_method("register_customer_served"):
		get_parent().call_deferred("register_customer_served")
		
	call_deferred("queue_free")
	
func launch(start_position: Vector2, end_position: Vector2, target_lane):
	global_position = start_position
	target_position = end_position
	lane = target_lane
	moving = true
	
func launch_on_path(drink_path_follow: PathFollow2D, target_lane):
	path_follow = drink_path_follow
	lane = target_lane
	path_progress = 0.0
	moving = true
	
	path_follow.progress = path_progress
	global_position = path_follow.global_position
	
func _physics_process(delta: float) -> void:
	if moving == false:
		return
		
	if path_follow != null:
		path_progress += speed * delta
		path_follow.progress = path_progress
		global_position = path_follow.global_position
		
		if path_follow.progress_ratio >= 1.0:
			moving = false
			arrived.emit(self, lane)
		return
	
	var direction := target_position - global_position
	var distance_this_frame := speed * delta
	
	if direction.length() <= distance_this_frame:
		global_position = target_position
		moving = false
		arrived.emit(self, lane)
		return
		
	global_position += direction.normalized() * distance_this_frame
