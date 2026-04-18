extends CharacterBody2D
signal glass_broke

@export var speed : float = 200.0
@export var drink_scene: PackedScene
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var footstep_sound: AudioStreamPlayer2D = $"../FootstepSound"
@onready var glass_clink_1: AudioStreamPlayer2D = $"../GlassClink1"
@onready var served_text: Label = $ServedText
@onready var glass_bottle_break: AudioStreamPlayer2D = $"../GlassBottleBreak"



var current_lane = null
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
#lane detection

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
		
	#serving
	if Input.is_action_just_pressed("serve"):
		if current_lane == null:
			glass_bottle_break.play()
			glass_broke.emit()
		elif current_lane.current_customer == null:
			glass_bottle_break.play()
			glass_broke.emit()
		else:
			glass_clink_1.play()
			print("Serving drink in lane:", current_lane)
			launch_drink()
			
			served_text.visible = true
			await get_tree().create_timer(0.5).timeout
			served_text.visible = false

#func _input(event):
#	if event.is_action_pressed("serve"):
#		if current_lane != null:
#			if current_lane.current_customer != null:
#				current_lane.current_customer.serve_customer()

func launch_drink() -> void:
	var drink = drink_scene.instantiate()
	get_parent().add_child(drink)
	
	var path_follow = current_lane.get_drink_path_follow()
	
	drink.arrived.connect(_on_drink_arrived)
	
	if path_follow != null:
		drink.launch_on_path(path_follow, current_lane)
	else:
		var start_position = current_lane.get_serve_start_global_position()
		var end_position = current_lane.get_stop_point_global_position()
		drink.launch(start_position, end_position, current_lane)
		
func _on_drink_arrived(drink, lane) -> void:
	if lane.current_customer != null:
		lane.current_customer.serve_customer()
		
	drink.queue_free()
