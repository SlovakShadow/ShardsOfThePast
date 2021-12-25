extends Node2D

var amountBeaten = 0
var bonk = 1
var kenji = 2

func _process(delta):
	if amountBeaten == 1:
		get_node("../Player1/MarginContainer/HBoxContainer/Boss_HB_2").set_texture(get_node("../Player1").blightpack_3_4)
	elif amountBeaten == 2:
		get_node("../Player1/MarginContainer/HBoxContainer/Boss_HB_2").set_texture(get_node("../Player1").blightpack_2_4)
	elif amountBeaten == 3:
		get_node("../Player1/MarginContainer/HBoxContainer/Boss_HB_2").set_texture(get_node("../Player1").blightpack_1_4)
	elif amountBeaten == 4:
		get_node("../Player1/MarginContainer/HBoxContainer/Boss_HB_2").set_texture(get_node("../Player1").blightpack_0_4)
