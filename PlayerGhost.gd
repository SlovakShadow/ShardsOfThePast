extends AnimatedSprite


func _process(delta):
	pass


func _on_PlayerGhost_animation_finished():
	queue_free()
