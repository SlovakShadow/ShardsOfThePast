extends Node2D

var walk_trigger_1 = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	if global_variables.currentCutscene == 1:
		get_node("PlayerCutscene1/Camera2D").current = true
	elif global_variables.currentCutscene == 2:
		get_node("PlayerCutscene2/Camera2D").current = true
	elif global_variables.currentCutscene == 3:
		get_node("PlayerCutscene3/Camera2D").current = true
