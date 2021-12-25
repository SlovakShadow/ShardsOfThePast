extends Node2D
var HP = 2
var taloned = false

func hurt(amount):
	HP = HP - amount
	$Sprite2.visible = true
	$Timer.start()
	if HP < 1:
		queue_free()
		
func _on_Timer_timeout():
	$Sprite2.visible = false
