extends CharacterBody2D
@export var speed: float = 100.00
@export var stop_point: Node2D

var state = "entering"
var current_lane = null


func _physics_process(_delta: float) -> void:
	if state == "entering":
		if global_position.x < stop_point.global_position.x:
			velocity.x = speed
		else:
			#Snap into place
			global_position.x = stop_point.global_position.x
			velocity.x = 0 
			state = "waiting"
	elif state == "leaving":
		velocity.x = -speed
	else:
		velocity.x = 0
	move_and_slide()
	
	if state == "leaving" and global_position.x < -20:
		get_parent().spawn_after_delay()
		queue_free()
		
func serve_customer():
	state = "leaving"
