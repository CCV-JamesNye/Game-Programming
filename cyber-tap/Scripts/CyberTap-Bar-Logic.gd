extends Node2D
var lives := 3

@onready var bartender__player_: CharacterBody2D = $"Bartender (Player)"
@onready var life_1: Sprite2D = $HealthBar/HBoxContainer/Life1
@onready var life_2: Sprite2D = $HealthBar/HBoxContainer/Life2
@onready var life_3: Sprite2D = $HealthBar/HBoxContainer/Life3

func _ready() -> void:
	bartender__player_.glass_broke.connect(_on_glass_broke)
	update_lives_ui()
	
func _on_glass_broke() -> void:
	lives -= 1
	update_lives_ui()
	
	if lives <- 0:
		get_tree().reload_current_scene()
		
func update_lives_ui() -> void:
	life_1.visible = lives >= 1
	life_2.visible = lives >= 2
	life_3.visible = lives >= 3
