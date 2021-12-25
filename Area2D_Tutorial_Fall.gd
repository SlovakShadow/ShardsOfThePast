extends Area2D

export(String, FILE, "*.tscn") var target_level
func _ready():
	target_level = preload("res://TheCaveLevel3.tscn")


func _process(delta):
	if get_parent().get_node("Player1").TransitionFinished == true:
		get_tree().change_scene("res://TheLabLevel1.tscn")


func _on_Area2D_Tutorial_Fall_body_entered(body):
	if body.name == "Player1":
		global_variables.maxBeatenLevel = 1
		body._save()
		body.Transition_out()
