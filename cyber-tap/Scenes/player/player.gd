extends CharacterBody2D

@export var speed := 200
var health : int = 3
var max_health : int = 3

func _physics_process(_delta: float) -> void:
	var direction : Vector2 = Vector2.ZERO
	
	if Input.is_action_pressed("right"):
		direction.x += 1
	if Input.is_action_pressed("left"):
		direction.x -= 1
	if Input.is_action_pressed("down"):
		direction.y += 1
	if Input.is_action_pressed("up"):
		direction.y -= 1
	
	velocity = direction.normalized() * speed
	move_and_slide()
