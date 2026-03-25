extends CharacterBody2D

@export var patrol_speed : float = 200.0
@export var gravity : float = 980
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var floor_detector: RayCast2D = $FloorDetector
@onready var sprite_2d: Sprite2D = $Sprite2D


var direction : Vector2 = Vector2.RIGHT

enum STATE {IDLE, PATROL}

var current_state : STATE = STATE.PATROL

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

func _process(_delta: float) -> void:
	if current_state == STATE.IDLE:
		velocity=Vector2.ZERO
		animation_player.play("idle")
	elif current_state == STATE.PATROL:
		animation_player.play("walk")
		velocity.x=direction.x*patrol_speed
		
	move_and_slide()
	if !floor_detector.is_colliding():
		if direction == Vector2.RIGHT:
			direction=Vector2.LEFT
			floor_detector.position.x = -23
			sprite_2d.flip_h = true
		else:
			direction=Vector2.RIGHT
			floor_detector.position.x = 23
			sprite_2d.flip_h = false
