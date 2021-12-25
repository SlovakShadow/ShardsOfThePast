extends Area2D


func _on_INSTAKILL_BLOCK_body_entered(body):
	body.dead()
