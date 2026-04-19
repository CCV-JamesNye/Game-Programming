extends CharacterBody2D

@export var speed: float = 100.00
@export var stop_point: Node2D

@onready var sprite: Sprite2D = $Sprite2D

var target_position: Vector2
var state = "entering"
var current_lane = null

var walk_right_frames := [6,7,8]
var walk_left_frames := [3,4,5]
var idle_frame := 1

var animation_timer := 0.0
var animation_speed := 0.15
var animation_index := 0

func _physics_process(delta: float) -> void:
	if state == "entering":
		if global_position.x < target_position.x:
			velocity.x = speed
			animate_walk(delta, walk_right_frames)
		else:
			#snap into place
			global_position.x = target_position.x
			velocity.x = 0
			state = "waiting"
			sprite.frame = idle_frame
	elif state == "leaving":
		velocity.x = -speed
		animate_walk(delta, walk_left_frames)
	else:
		velocity.x = 0
		sprite.frame = idle_frame
			
	move_and_slide()
		
	if state == "leaving" and global_position.x < -20:
		if get_parent().has_method("spawn_after_delay"):
			get_parent().spawn_after_delay()
		queue_free()

func serve_customer():
	state = "leaving"
	
func move_to_position(new_target_position: Vector2) -> void:
	target_position = new_target_position
	state = "entering"
	
func animate_walk(delta: float, frames: Array) -> void:
	animation_timer += delta
	
	if animation_timer >= animation_speed:
		animation_timer = 0.0
		animation_index = (animation_index + 1) % frames.size()
		sprite.frame = frames[animation_index]
