extends Node2D

var Current_Shake_Priority = 0

func move_camera(vector):
	if get_parent().get_node("PlayerVarHolder").PlayerAlive == true:
		get_parent().get_node("Player1").get_node("Camera2D").offset = Vector2(rand_range(-vector.x, vector.x), rand_range(-vector.y, vector.y))
	
func screen_shake(shake_lenght, shake_power,shake_priority):
	if get_parent().get_node("PlayerVarHolder").PlayerAlive == true:
		if shake_priority > Current_Shake_Priority:
			Current_Shake_Priority = shake_priority
			$Tween.interpolate_method(self, "move_camera", Vector2(shake_power, shake_power), Vector2(0,0), shake_lenght, Tween.TRANS_SINE, Tween.EASE_OUT, 0)
			$Tween.start()

func _on_Tween_tween_completed(object, key):
	Current_Shake_Priority = 0
