extends Sprite2D

var speed: float = 200.0
var direction: Vector2 = Vector2.DOWN

func _process(delta: float) -> void:
	position += direction * speed * delta
