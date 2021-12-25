extends Particles2D
	
func timestart():
	$Timer.start()

func _on_Timer_timeout():
	queue_free()
