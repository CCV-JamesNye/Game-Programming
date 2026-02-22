extends Node2D

#Speed
@export var speed : float = 200

#Player Movement
func _process(delta: float) -> void:
	#Store Direction
	var direction : Vector2 = Vector2.ZERO

#Apply Movement
	#Read Input
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_down"):
		direction.y += 1
	if Input.is_action_pressed("move_up"):
		direction.y -= 1
	
	position += direction.normalized() * speed * delta
	pass
	
	
	
