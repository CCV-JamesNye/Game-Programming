class_name Player extends CharacterBody2D



@onready var state_label: Label = $StateLabel
@export var speed : float = 275
@export var gravity : float = 980.0
@export var jump_force : float = -400
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D

var jumping = false


#Node enters scene tree
func _ready() -> void: 
	pass #replace with function body

#Player Movement
func _process(_delta: float) -> void:
	state_label.text = str(is_on_floor())
	pass

func _physics_process( delta: float) -> void:
	if !is_on_floor():
		velocity.y += gravity * delta
	
	
		#Store Direction
	var direction : Vector2 = Vector2.ZERO
	
	# cis2295 "implementing collisions" has killing player by falling into hole. I can use that. (see also barrelfirehazard script)
#Apply Movement

	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	
	if jumping:
		animation_player.play("jump")
		
	elif direction != Vector2.ZERO:
		animation_player.play("walk")
	
		if direction.x <0:
			sprite_2d.flip_h = true
		else: 
			sprite_2d.flip_h = false
	
	else:
		animation_player.play("idle")
		
	
	velocity.x = direction.normalized().x * speed
	move_and_slide()
	
	if is_on_floor() and jumping:
		jumping = false
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump") and is_on_floor():
		velocity.y = jump_force
		jumping = true
		
func die() -> void: 
	call_deferred("_go_to_game_over")
	
func _go_to_game_over():
	get_tree().change_scene_to_file("res://Scenes/UI/game_over.tscn")
