extends Area2D

func _on_Area2D_body_entered(body):
	if body.name == "Player1":
		$Sprite.visible

func _on_Area2D_area_entered(area):
	if area.name == "Player1":
		$Sprite.visible
