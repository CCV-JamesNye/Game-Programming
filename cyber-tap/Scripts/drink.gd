extends Area2D

signal arrived(drink, lane)

@export var speed: float = 250.0

var lane = null
var target_position: Vector2
var moving:= false

func launch(start_position: Vector2, end_position: Vector2, target_lane):
	global_position = start_position
	target_position = end_position
	lane = target_lane
	moving = true
	
func _physics_process(delta: float) -> void:
	if moving == false:
		return
	var direction := target_position - global_position
	var distance_this_frame := speed * delta
	
	if direction.length() <= distance_this_frame:
		global_position = target_position
		moving = false
		arrived.emit(self, lane)
		return
		
	global_position += direction.normalized() * distance_this_frame
