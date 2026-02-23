extends CharacterBody2D

#Speed
@export var speed : float = 200
@export var gravity : float = 980.0


#Node enters scene tree
func _ready() -> void: 
	pass #replace with function body

#Player Movement
func _process(_delta: float) -> void:
	pass

func _physics_process( delta: float) -> void:
	
		#Store Direction
	var direction : Vector2 = Vector2.ZERO
	velocity.y += gravity * delta
	
#Apply Movement
	#Read Input
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	
	velocity.x = direction.normalized().x * speed
	move_and_slide()
	
