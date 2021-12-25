extends AnimatedSprite
onready var global_vars = get_node("/root/global_variables")

func _on_Area2D_body_entered(body):
	if body.name == "Player1":
		if get_parent().Added == 0:
			global_vars.maxHP = global_vars.maxHP + 1
			get_parent().Added = 1
			get_parent().taken()
			body.ready_HP()
