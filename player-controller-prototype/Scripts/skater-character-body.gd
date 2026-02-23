extends CharacterBody2D

@onready var state_label: Label = $StateLabel

#Speed
@export var speed : float = 375
@export var gravity : float = 980.0
@export var jump_force : float = -400

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
	#Read Input
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	
	velocity.x = direction.normalized().x * speed
	move_and_slide()
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump") and is_on_floor():
		velocity.y = jump_force
