extends Area2D



func _on_Pit_body_entered(body):
	if "Player1" in body.name:
		body.dead()
