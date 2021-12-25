extends Node

onready var global_vars = get_node("/root/global_variables")
onready var SaveLoad = get_node("/root/SaveLoad")
var tvoverlay_off = preload("res://Placeholder Textures for Shards of the Past/tvoverlay_off.png")
var tvoverlay_on = preload("res://Placeholder Textures for Shards of the Past/tvoverlay_on.png")
var fg_pic = preload("res://Placeholder Textures for Shards of the Past/achievements/extinguished-unlocked.png")
var fg_txt = preload("res://Placeholder Textures for Shards of the Past/achievements/extinguished-text-unlocked.png")
var tb_pic = preload("res://Placeholder Textures for Shards of the Past/achievements/fast_and_slashing-unlocked.png")
var tb_txt = preload("res://Placeholder Textures for Shards of the Past/achievements/fast_and_slashing-text-unlocked.png")
var mine_pic = preload("res://Placeholder Textures for Shards of the Past/achievements/into_the_stratosphere-unlocked.png")
var mine_txt = preload("res://Placeholder Textures for Shards of the Past/achievements/into_the_stratosphere-text-unlocked.png")
var srl_pic = preload("res://Placeholder Textures for Shards of the Past/achievements/going_ballistic-unlocked.png")
var srl_txt = preload("res://Placeholder Textures for Shards of the Past/achievements/going_ballistic-text-unlocked.png")
var level1graph = preload("res://Placeholder Textures for Shards of the Past/level_select/lab-icon.png")
var level2graph = preload("res://Placeholder Textures for Shards of the Past/level_select/milcamp-icon.png")
var level3graph = preload("res://Placeholder Textures for Shards of the Past/level_select/desert-icon.png")
var level4graph = preload("res://Placeholder Textures for Shards of the Past/level_select/dungeon-icon.png")
var level5graph = preload("res://Placeholder Textures for Shards of the Past/level_select/cave-icon.png")
var level6graph = preload("res://Placeholder Textures for Shards of the Past/level_select/dreamscape-icon.png")
var level7graph = preload("res://Placeholder Textures for Shards of the Past/level_select/enemybase-icon.png")
var level8graph = preload("res://Placeholder Textures for Shards of the Past/level_select/warehouse-icon.png")
var level9graph = preload("res://Placeholder Textures for Shards of the Past/level_select/breach-icon.png")

func _ready():
	global_vars.tumblebladeBeaten = false
	global_vars.fieryGoliathBeaten = false
	global_vars.steppedOnMine = false
	global_vars.srlBeaten = false
	global_vars.hp0taken = false
	global_vars.hp1taken = false
	global_vars.hp2taken = false
	global_vars.hp3taken = false
	global_vars.hp4taken = false
	global_vars.blightmotherBeaten = false
	SaveLoad._load()
	if self.name == "achievements":
		if global_vars.fieryGoliathBeaten == true:
			$A1/sprite1.texture = fg_pic
			$A1/txt1.texture = fg_txt
		if global_vars.tumblebladeBeaten == true:
			$A1/sprite3.texture = tb_pic
			$A1/txt3.texture = tb_txt
		if global_vars.steppedOnMine == true:
			$A1/sprite2.texture = mine_pic
			$A1/txt2.texture = mine_txt
		if global_vars.srlBeaten == true:
			$A2/sprite1.texture = srl_pic
			$A2/txt1.texture = srl_txt
	if self.name == "level_select":
		if global_vars.maxBeatenLevel >= 1:
			$GridContainer/level1.texture_normal = level1graph
		if global_vars.maxBeatenLevel >= 2:
			$GridContainer/level2.texture_normal = level2graph
		if global_vars.maxBeatenLevel >= 3:
			$GridContainer/level3.texture_normal = level3graph
		if global_vars.maxBeatenLevel >= 4:
			$GridContainer/level4.texture_normal = level4graph
		if global_vars.maxBeatenLevel >= 5:
			$GridContainer/level5.texture_normal = level5graph
		if global_vars.maxBeatenLevel >= 6:
			$GridContainer/level6.texture_normal = level6graph
		if global_vars.maxBeatenLevel >= 7:
			$GridContainer/level7.texture_normal = level7graph
		if global_vars.maxBeatenLevel >= 8:
			$GridContainer/level8.texture_normal = level8graph
		if global_vars.maxBeatenLevel >= 9:
			$GridContainer/level9.texture_normal = level9graph
		if global_vars.maxBeatenLevel >= 10:
			pass
#			$GridContainer/level10.texture_normal = level10graph

#func _on_TextureButton_pressed():
#	if global_vars.currentLevel == 0:
#		get_tree().change_scene("res://TutorialLevel.tscn")
#	elif global_vars.currentLevel == 1:
#		get_tree().change_scene("res://TheLabLevel1.tscn")
#	elif global_vars.currentLevel == 2:
#		get_tree().change_scene("res://MilCampLevel2.tscn")
#	elif global_vars.currentLevel == 3:
#		get_tree().change_scene("res://DesertLevel5.tscn")
#	elif global_vars.currentLevel == 4:
#		get_tree().change_scene("res://DungeonLevel6.tscn")
#	elif global_vars.currentLevel == 5:
#		get_tree().change_scene("res://TheCaveLevel3.tscn")

func _on_TextureButton_pressed():
	get_tree().change_scene("res://level_select.tscn")

func _on_TextureButton2_pressed():
	get_tree().change_scene("res://settings.tscn")

func _on_TextureButton3_pressed():
	get_tree().quit()

func _on_TextureButton4_pressed():
	if global_vars.tv_overlay == 1:
		global_vars.tv_overlay = 0
		$MarginContainer/VBoxContainer/TextureButton4.texture_normal = tvoverlay_off
	elif global_vars.tv_overlay == 0:
		global_vars.tv_overlay = 1
		$MarginContainer/VBoxContainer/TextureButton4.texture_normal = tvoverlay_on


func _physics_process(delta):
	if global_vars.tv_overlay == 0:
		$Control.hide()
	elif global_vars.tv_overlay == 1:
		$Control.show()


func _on_TextureButton6_pressed():
	get_tree().change_scene("res://achievements.tscn")


func _on_back_pressed():
	get_tree().change_scene("res://TitleScreen.tscn")
	


func _on_level0_pressed():
	get_tree().change_scene("res://TutorialLevel.tscn")


func _on_level1_pressed():
	if $GridContainer/level1.texture_normal == level1graph:
		get_tree().change_scene("res://TheLabLevel1.tscn")


func _on_level2_pressed():
	if $GridContainer/level2.texture_normal == level2graph:
		get_tree().change_scene("res://MilCampLevel2.tscn")


func _on_level3_pressed():
	if $GridContainer/level3.texture_normal == level3graph:
		get_tree().change_scene("res://DesertLevel5.tscn")


func _on_level4_pressed():
	if $GridContainer/level4.texture_normal == level4graph:
		get_tree().change_scene("res://DungeonLevel6.tscn")


func _on_level5_pressed():
	if $GridContainer/level5.texture_normal == level5graph:
		get_tree().change_scene("res://TheCaveLevel3.tscn")


func _on_level6_pressed():
	if $GridContainer/level6.texture_normal == level6graph:
		get_tree().change_scene("res://DreamscapeLevel7.tscn")


func _on_level7_pressed():
	if $GridContainer/level7.texture_normal == level7graph:
		get_tree().change_scene("res://EnemyBaseLevel8.tscn")


func _on_level8_pressed():
	if $GridContainer/level8.texture_normal == level8graph:
		get_tree().change_scene("res://WarehouseLevel9.tscn")


func _on_level9_pressed():
	if $GridContainer/level9.texture_normal == level9graph:
		get_tree().change_scene("res://TheBreachLevel10.tscn")
