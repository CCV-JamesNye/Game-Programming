extends Area2D


func _on_body_entered(body):
	if body.name == "Bartender (Player)":
		body.near_tap = true
		
func _on_body_exited(body):
	if body.name == "Bartender (Player)":
		body.near_tap = false
