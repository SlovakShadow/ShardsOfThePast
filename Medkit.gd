extends Area2D

var particles = preload("res://Placeholder Textures for Shards of the Past/health/heartparticles.png")

func _on_Area2D_body_entered(body):
	if body.name == "Player1":
		get_node("Sprite").set_texture(particles)
		$Timer.start()
		$Timer2.start()
		$Timer3.start()
		body.full_heal()


func _on_Timer_timeout():
	queue_free()

func _on_Timer2_timeout():
	get_node("Sprite").offset = Vector2(0, -2)

func _on_Timer3_timeout():
	get_node("Sprite").offset = Vector2(0, -4)
