extends Area2D

export(String, FILE, "*.tscn") var target_level
func _ready():
	target_level = preload("res://MilCampLevel2.tscn")

func _process(delta):
	if get_parent().get_node("Player1").TransitionFinished == true:
		global_variables.currentCutscene = 1
		get_tree().change_scene("res://Cutscene1.tscn")
#		get_tree().change_scene("res://MilCampLevel2.tscn")
		

func _on_Area2D_Lab_Elevator_body_entered(body):
	if body.name == "Player1":
		global_variables.maxBeatenLevel = 2
		body._save()
		body.Transition_out()
