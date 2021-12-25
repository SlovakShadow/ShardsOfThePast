extends Area2D
var override = false


func _on_Area2D_body_entered(body):
	if body.name == "Player1":
		override = true
	if override == true:
		body.Is_Attacking = true
		body.velocity.y = 1000


func _on_Area2D_body_exited(body):
	if body.name == "Player1":
		override = false
		body.Is_Attacking = false
