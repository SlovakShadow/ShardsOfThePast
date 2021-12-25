extends Area2D

export(String, FILE, "*.tscn") var target_level
func _ready():
	if self.name == "Area2D_MilCamp_Exit":
		target_level = load("res://DesertLevel5.tscn")
	elif self.name == "Area2D_Desert_Exit":
		target_level = load("res://DungeonLevel6.tscn")
	elif self.name == "Area2D_Dungeon_Exit":
		target_level = load("res://TheCaveLevel3.tscn")


func _process(delta):
	if get_parent().get_node("Player1").TransitionFinished == true:
		if self.name == "Area2D_Desert_Exit":
			global_variables.maxBeatenLevel = 4
			get_tree().change_scene("res://DungeonLevel6.tscn")
		elif self.name == "Area2D_MilCamp_Exit":
			global_variables.maxBeatenLevel = 3
			get_tree().change_scene("res://DesertLevel5.tscn")
		elif self.name == "Area2D_Dungeon_Exit":
			global_variables.maxBeatenLevel = 5
			get_tree().change_scene("res://TheCaveLevel3.tscn")
		elif self.name == "Area2D_Cave_Exit":
			global_variables.maxBeatenLevel = 6
			global_variables.currentCutscene = 2
			get_tree().change_scene("res://Cutscene1.tscn")
#			get_tree().change_scene("res://DreamscapeLevel7.tscn")
		elif self.name == "Area2D_Dreamscape_Exit":
			global_variables.maxBeatenLevel = 7
			get_tree().change_scene("res://EnemyBaseLevel8.tscn")
		elif self.name == "Area2D_EnemyBase_Exit":
			global_variables.maxBeatenLevel = 8
			global_variables.currentCutscene = 3
			get_tree().change_scene("res://Cutscene1.tscn")
		elif self.name == "Area2D_Warehouse_Exit":
			global_variables.maxBeatenLevel = 9
			get_tree().change_scene("res://TheBreachLevel10.tscn")
		elif self.name == "Area2D_Breach_Exit":
			global_variables.maxBeatenLevel = 10
			get_tree().change_scene("res://TitleScreen.tscn")


func _on_Area2D_MilCamp_Exit_body_entered(body):
	if body.name == "Player1":
		body._save()
		body.Transition_out()
