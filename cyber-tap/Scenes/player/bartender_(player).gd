extends CharacterBody2D
@export var speed : float = 200.0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var footstep_sound: AudioStreamPlayer2D = $"../FootstepSound"
@onready var glass_clink_1: AudioStreamPlayer2D = $"../GlassClink1"


var current_lane = 0
var lanes = []

func _ready():
	lanes = [
		($"../Lane1"),
		($"../Lane2"),
		($"../Lane3"),
		($"../Lane4"),
	]

func _physics_process(_delta):
	var direction = Vector2.ZERO
#movement
	if Input.is_action_pressed("right"):
		direction.x += 1
	if Input.is_action_pressed("left"):
		direction.x -= 1
	if Input.is_action_pressed("down"):
		direction.y += 1
	if Input.is_action_pressed("up"):
		direction.y -= 1
	direction = direction.normalized()
	velocity = direction * speed
	move_and_slide()
#movement sound
	if direction.length() > 0:
		if !footstep_sound.playing:
			footstep_sound.play()
	else:
		footstep_sound.stop()

#direction
	if direction.x > 0:
		animated_sprite_2d.play("walk_right")
	elif direction.x < 0:
		animated_sprite_2d.play("walk_left")
	elif direction.y < 0:
		animated_sprite_2d.play("walk_up")
	elif direction.y > 0:
		animated_sprite_2d.play("walk_down")
	else:
		animated_sprite_2d.play("idle")
		
	#lane detectiion
	if Input.is_action_just_pressed("serve"):
		glass_clink_1.play()
		print("Serving drink in lane:", current_lane)
