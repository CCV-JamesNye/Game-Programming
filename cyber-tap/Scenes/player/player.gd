extends CharacterBody2D

signal health_update (int)

@export var speed := 200
var health : int = 3
var max_health : int = 3
@onready var hurt_box: Area2D = $HurtBox

func _ready() -> void:
	hurt_box.take_damage.connect ( _take_damage )
	pass

func _take_damage ( damage: int ) -> void:
	health -= damage
	printerr (health)
	health_update.emit( health )
	if health <= 0:
		die()
	
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

func die () -> void:
	print ("Player Died!")
	get_tree().call_deferred('reload_current_scene')
	
	
