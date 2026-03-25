extends CharacterBody2D

@export var patrol_speed : float = 50.0
@export var gravity : float = 980
@onready var animation_player: AnimationPlayer = $AnimationPlayer


var direction : Vector2 = Vector2.RIGHT

enum STATE {IDLE, PATROL}

var current_state : STATE = STATE.IDLE

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

	move_and_slide()

func _process(_delta: float) -> void:
	if current_state == STATE.IDLE:
		animation_player.play("idle")
	elif current_state == STATE.PATROL:
		animation_player.play("walk")
