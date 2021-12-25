extends Area2D

var pickUp = preload("res://Placeholder Textures for Shards of the Past/health/healthBoostSecret_pickedUp.png")

func _on_Area2D_body_entered(body):
	if body.name == "Player1":
		get_node("Sprite").set_texture(pickUp)
		$Timer.start()
		body.maxHP = body.maxHP + 1
		body.ready_HP()


func _on_Timer_timeout():
	queue_free()
