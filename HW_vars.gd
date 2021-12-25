extends Node2D

var Added = 0
onready var global_vars = get_node("/root/global_variables")

func taken():
	if get_parent().name == "TutorialLevel":
		global_vars.hp1taken = true
	elif get_parent().name == "MilCampLevel2":
		global_vars.hp2taken = true
	elif get_parent().name == "DungeonLevel6":
		global_vars.hp3taken = true
	elif get_parent().name == "TheCaveLevel3":
		global_vars.hp4taken = true
