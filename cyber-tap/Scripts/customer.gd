extends CharacterBody2D
@export var speed: float = 100.00
@export var stop_point: Node2D

var state = "entering"
var current_lane = null


func _physics_process(_delta: float) -> void:
	print("moving")
	if state == "entering":
		if position.x < stop_point.global_position.x:
			velocity.x = speed
		else:
			velocity.x = 0 
			state = "waiting"
	else:
		velocity.x = 0
	
	move_and_slide()
