extends KinematicBody2D

const Speed = 70
const Grav = 10
const JumpPower = -235
const Floor = Vector2(0, -1)
const Fireball = preload("res://Fireball.tscn")
const JumpSmoke = preload("res://JumpSmoke.tscn")
const PlrGhost = preload("res://PlayerGhost.tscn")
var velocity = Vector2()
var on_ground = false
var FS = 1
var Is_Attacking = false
onready var global_vars = get_node("/root/global_variables")
onready var SaveLoad = get_node("/root/SaveLoad")
var HP = 5
var file = File.new()
var displaySign = false
var signOpened = false
var canSignBeUsed = true
var signID = "0_0"
var dialoguePart = 11
var dialogueRow = 0
var dialogueOpened = false
var dialogueRange = false
var canDialogueBeUsed = true

var dashing = false
var isOnLadder = false
var self_y = 0
var isUsingLadder = false
var canChangeLadderState = true

var dialogue_position = 11
var dialogue_error = preload("res://Placeholder Textures for Shards of the Past/dialogue/error.png")

var dialogue_lab_1 = preload("res://Placeholder Textures for Shards of the Past/dialogue/dialogue_player_lab_1.png")
var dialogue_lab_2 = preload("res://Placeholder Textures for Shards of the Past/dialogue/dialogue_player_lab_2.png")
var lab_paper = preload("res://Placeholder Textures for Shards of the Past/sign/info_paper.png")
var dialogue_lab_3 = preload("res://Placeholder Textures for Shards of the Past/dialogue/dialogue_player_lab_3.png")

var dialogue_cave_1 = preload("res://Placeholder Textures for Shards of the Past/dialogue/dialogue_general_cave_cutscene.png")

var dialogue_truck_1 = preload("res://Placeholder Textures for Shards of the Past/dialogue/dialogue_truck_1.png")
var dialogue_truck_2 = preload("res://Placeholder Textures for Shards of the Past/dialogue/dialogue_truck_2.png")
var dialogue_truck_3 = preload("res://Placeholder Textures for Shards of the Past/dialogue/dialogue_truck_3.png")
var dialogue_truck_4 = preload("res://Placeholder Textures for Shards of the Past/dialogue/dialogue_truck_4.png")
var dialogue_truck_5 = preload("res://Placeholder Textures for Shards of the Past/dialogue/dialogue_truck_5.png")
var dialogue_truck_6 = preload("res://Placeholder Textures for Shards of the Past/dialogue/dialogue_truck_6.png")
var dialogue_truck_7 = preload("res://Placeholder Textures for Shards of the Past/dialogue/dialogue_truck_7.png")
var dialogue_truck_8 = preload("res://Placeholder Textures for Shards of the Past/dialogue/dialogue_truck_8.png")
var dialogue_truck_9 = preload("res://Placeholder Textures for Shards of the Past/dialogue/dialogue_truck_9.png")
var dialogue_truck_10 = preload("res://Placeholder Textures for Shards of the Past/dialogue/dialogue_truck_10.png")

var lab_ambience = preload("res://sfx/lab_ambient.ogg")
var milcamp_ambience = preload("res://sfx/milcamp_ambient.ogg")
var desert_ambience = preload("res://sfx/desert_ambient.ogg")
var dungeon_ambience = preload("res://sfx/dungeon_ambient.ogg")
var cave_ambience = preload("res://sfx/cave_ambient.ogg")
var dreamscape_ambience = preload("res://sfx/dreamscape_ambient.ogg")
var enemybase_ambience = preload("res://sfx/enemybase_ambient.ogg")
var warehouse_ambience = preload("res://sfx/warehouse_ambient.ogg")

var active_ability = 1
var active_movement_ability = 1
var projectile = false
var Direction = 1
var pausemenushown = -1
var dashable = false
var jump_count = 0
var shadow_spawnable = true
var can_change_jc = true
var dashableStateChangable = true
var timer_started = false
var can_dash = true
var escapeDialogueActivated = false
var dashDialogueActivated = false
var lifesteal_unlocked = false
var dash_unlocked = false
var TransitionFinished = false
var Transition_in_out = 0

var animation_walk_trigger = false

var progress = 1
var canAdvance = true

func achievement_recieved(texture):
	$MarginContainer/HBoxContainer/Achievement.texture = texture
	$MarginContainer/HBoxContainer/Achievement.show()
	$Timer13.start()

func hit_by_dart():
	$"MarginContainer/HBoxContainer/Dialogue".hide()
	$AnimatedSprite.play("hit_by_dart")
	$Timer2.start()
	

func _ready():
	SaveLoad._load()
	if global_vars.tv_overlay == 0:
		$Shader/Control.hide()
	else:
		$Shader/Control.show()
	$RichTextLabel.text = str(global_vars.maxHP)
	Transition_in()
	progress = 1
	if global_variables.currentCutscene == 1:
		dialoguePart = 12
		$"MarginContainer/HBoxContainer/Sign".hide()
		$"MarginContainer/HBoxContainer/Dialogue".texture = dialogue_lab_1
		$"MarginContainer/HBoxContainer/Dialogue".show()
	elif global_variables.currentCutscene == 2:
		dialoguePart = 21
	elif global_variables.currentCutscene == 3:
		dialoguePart = 30
	


func Transition_in():
	Transition_in_out = 1
	$Timer15.start()
	$Transition.modulate.a -= 0.1
	if $Transition.modulate.a <= 0:
		pass


func Transition_out():
	Transition_in_out = 2
	$Timer15.start()
	$Transition.modulate.a += 0.1
	if $Transition.modulate.a >= 1:
		pass
			

func _on_Timer15_timeout():
	if Transition_in_out == 1:
		if $Transition.modulate.a <= 0:
			pass
		else:
			$Transition.modulate.a -= 0.03
			$Timer15.start()
	elif Transition_in_out == 2:
		if $Transition.modulate.a >= 1:
			TransitionFinished = true
		else:
			$Transition.modulate.a += 0.03
			$Timer15.start()
	


func _process(delta: float) -> void:
#	if !$Music.is_playing():
#		if get_parent().name == "TutorialLevel":
#			$Music.stream = lab_ambience
#		elif get_parent().name == "TheLabLevel1":
#			$Music.stream = lab_ambience
#		elif get_parent().name == "MilCampLevel2":
#			$Music.stream = milcamp_ambience
#		elif get_parent().name == "DesertLevel5":
#			$Music.stream = desert_ambience
#		elif get_parent().name == "DungeonLevel6":
#			$Music.stream = dungeon_ambience
#		elif get_parent().name == "TheCaveLevel3":
#			$Music.stream = cave_ambience
#		elif get_parent().name == "DreamscapeLevel7":
#			$Music.stream = dreamscape_ambience
#		elif get_parent().name == "EnemyBaseLevel8":
#			$Music.stream = enemybase_ambience
#		elif get_parent().name == "WarehouseLevel9":
#			$Music.stream = warehouse_ambience
#		$Music.play()
	pass

func _physics_process(delta):
	if dialoguePart == 22:
		$"MarginContainer/HBoxContainer/Sign".hide()
		$"MarginContainer/HBoxContainer/Dialogue".texture = dialogue_cave_1
		$"MarginContainer/HBoxContainer/Dialogue".show()
		dialoguePart += 1
		canDialogueBeUsed = false
		$Timer6.start()
		
	if TransitionFinished == true:
		if global_variables.currentCutscene == 1:
			get_tree().change_scene("res://MilCampLevel2.tscn")
		elif global_variables.currentCutscene == 2:
			get_tree().change_scene("res://DreamscapeLevel7.tscn")
		elif global_variables.currentCutscene == 3:
			get_tree().change_scene("res://TheBreachLevel10.tscn")
	if Input.is_action_pressed("ui_open"):
		if progress == 1:
			$skip_text.visible = true
			$Timer8.start()
		if progress == 2:
			if global_variables.currentCutscene == 1:
				$"MarginContainer/HBoxContainer/Dialogue".hide()
				get_parent().walk_trigger_1 = true
				$AnimatedSprite.play("climb_idle")
				get_parent().get_node("cutsceneDoor").animationDoor = 2
				$Timer3.start()
			elif global_variables.currentCutscene == 2:
				$"MarginContainer/HBoxContainer/Dialogue".hide()
				$Timer4.start()
			elif global_variables.currentCutscene == 3:
				$"MarginContainer/HBoxContainer/Dialogue".hide()
				$AnimatedSprite.play("idle")
				$Timer4.start()
			
			
			
			
		if Input.is_action_just_pressed("ui_pause"):
			if signOpened == true:
				$"MarginContainer/HBoxContainer/Sign".hide()
			else:
				pausemenushown = pausemenushown * -1
				if pausemenushown == 1:
					$MarginContainer2.show()
				elif pausemenushown == -1:
					$MarginContainer2.hide()
		velocity.y = velocity.y + Grav
		var new_file = File.new()
		# See if there is a savegame to load, else stop
		if not new_file.file_exists("res://savegame.txt"):
			return
		# Read the contents of the savegame
		new_file.open("res://savegame.txt", File.READ)
		# Assign a variable to the contents of the file
		# get_as_text() means it's in the form of a string
		var data = new_file.get_as_text()
		# Close the File, as we don't need it anymore
		new_file.close()
		#$RichTextLabel.text = str(data)
		


func _on_Timer_timeout():
	get_parent().get_node("PlayerVarHolder").PlayerAlive = false
	queue_free()
	



func _on_TextureButton2_pressed():
	get_tree().reload_current_scene()


func _on_TextureButton3_pressed():
	get_tree().change_scene("res://TitleScreen.tscn")


func _on_TextureButton4_pressed():
	get_tree().quit()



func _on_Timer6_timeout():
	if canDialogueBeUsed == false:
		canDialogueBeUsed = true
	if canSignBeUsed == false:
		canSignBeUsed = true
	



func _on_Timer9_timeout():
	can_change_jc = true


func _on_Timer13_timeout():
	$MarginContainer/HBoxContainer/Achievement.hide()
			


func _on_Timer14_timeout():
	$RichTextLabel.text = str(dialoguePart)
	if progress == 1:
		if dialoguePart == 11:
			if canDialogueBeUsed == true:
				$"MarginContainer/HBoxContainer/Sign".hide()
				$"MarginContainer/HBoxContainer/Dialogue".texture = dialogue_lab_1
				$"MarginContainer/HBoxContainer/Dialogue".show()
				dialoguePart += 1
				canDialogueBeUsed = false
				$Timer6.start()
		elif dialoguePart == 12:
			if canDialogueBeUsed == true:
				$"MarginContainer/HBoxContainer/Dialogue".texture = dialogue_lab_2
				$"MarginContainer/HBoxContainer/Dialogue".show()
				dialoguePart += 1
				canDialogueBeUsed = false
				$Timer6.start()
		elif dialoguePart == 13:
			if canDialogueBeUsed == true:
				$"MarginContainer/HBoxContainer/Dialogue".hide()
				$"MarginContainer/HBoxContainer/Sign".texture = lab_paper
				$"MarginContainer/HBoxContainer/Sign".show()
				dialoguePart += 1
				canDialogueBeUsed = false
				$Timer6.start()
		elif dialoguePart == 14:
			if canDialogueBeUsed == true:
				$"MarginContainer/HBoxContainer/Sign".hide()
				$"MarginContainer/HBoxContainer/Dialogue".texture = dialogue_lab_3
				$"MarginContainer/HBoxContainer/Dialogue".show()
				dialoguePart += 1
				canDialogueBeUsed = false
				$Timer6.start()
		elif dialoguePart == 15:
			if canDialogueBeUsed == true:
				if canAdvance == true:
					$"MarginContainer/HBoxContainer/Dialogue".hide()
					get_parent().walk_trigger_1 = true
					$AnimatedSprite.play("climb_idle")
					get_parent().get_node("cutsceneDoor").animationDoor = 2
					$Timer3.start()
					canAdvance = false
					
		elif dialoguePart == 23:
			if canDialogueBeUsed == true:
				if canAdvance == true:
					$"MarginContainer/HBoxContainer/Dialogue".hide()
					canAdvance = false
					
		if dialoguePart == 30:
			if canDialogueBeUsed == true:
				$"MarginContainer/HBoxContainer/Sign".hide()
				$"MarginContainer/HBoxContainer/Dialogue".texture = dialogue_truck_1
				$"MarginContainer/HBoxContainer/Dialogue".show()
				dialoguePart += 1
				canDialogueBeUsed = false
				$Timer6.start()
		elif dialoguePart == 31:
			if canDialogueBeUsed == true:
				$"MarginContainer/HBoxContainer/Sign".hide()
				$"MarginContainer/HBoxContainer/Dialogue".texture = dialogue_truck_2
				$"MarginContainer/HBoxContainer/Dialogue".show()
				dialoguePart += 1
				canDialogueBeUsed = false
				$Timer6.start()
		elif dialoguePart == 32:
			if canDialogueBeUsed == true:
				$"MarginContainer/HBoxContainer/Dialogue".texture = dialogue_truck_3
				$"MarginContainer/HBoxContainer/Dialogue".show()
				dialoguePart += 1
				canDialogueBeUsed = false
				$Timer6.start()
		elif dialoguePart == 33:
			if canDialogueBeUsed == true:
				$"MarginContainer/HBoxContainer/Dialogue".texture = dialogue_truck_4
				$"MarginContainer/HBoxContainer/Dialogue".show()
				dialoguePart += 1
				canDialogueBeUsed = false
				$Timer6.start()
		elif dialoguePart == 34:
			if canDialogueBeUsed == true:
				$"MarginContainer/HBoxContainer/Dialogue".texture = dialogue_truck_5
				$"MarginContainer/HBoxContainer/Dialogue".show()
				dialoguePart += 1
				canDialogueBeUsed = false
				$Timer6.start()
		elif dialoguePart == 35:
			if canDialogueBeUsed == true:
				$"MarginContainer/HBoxContainer/Dialogue".texture = dialogue_truck_6
				$"MarginContainer/HBoxContainer/Dialogue".show()
				dialoguePart += 1
				canDialogueBeUsed = false
				$Timer6.start()
		elif dialoguePart == 36:
			if canDialogueBeUsed == true:
				$"MarginContainer/HBoxContainer/Dialogue".texture = dialogue_truck_7
				$"MarginContainer/HBoxContainer/Dialogue".show()
				dialoguePart += 1
				canDialogueBeUsed = false
				$Timer6.start()
		elif dialoguePart == 37:
			if canDialogueBeUsed == true:
				$"MarginContainer/HBoxContainer/Dialogue".texture = dialogue_truck_8
				$"MarginContainer/HBoxContainer/Dialogue".show()
				dialoguePart += 1
				canDialogueBeUsed = false
				$Timer6.start()
		elif dialoguePart == 38:
			if canDialogueBeUsed == true:
				$"MarginContainer/HBoxContainer/Dialogue".texture = dialogue_truck_9
				$"MarginContainer/HBoxContainer/Dialogue".show()
				dialoguePart += 1
				canDialogueBeUsed = false
				$Timer6.start()
		elif dialoguePart == 39:
			if canDialogueBeUsed == true:
				$"MarginContainer/HBoxContainer/Dialogue".texture = dialogue_truck_10
				$"MarginContainer/HBoxContainer/Dialogue".show()
				dialoguePart = 391
				canDialogueBeUsed = false
				$Timer6.start()
		elif dialoguePart == 391:
			if canDialogueBeUsed == true:
				$"MarginContainer/HBoxContainer/Dialogue".hide()
				canAdvance = false
				Transition_out()
				
	$Timer14.start()
	


func _on_Timer2_timeout():
	Transition_out()


func _on_Timer3_timeout():
	$AnimatedSprite.play("back_walk")
	$Timer4.start()
	
	
func _on_Timer4_timeout():
	if global_variables.currentCutscene == 1:
		$AnimatedSprite.play("idle")
		get_parent().get_node("cutsceneDoor").animationDoor = 3
		self.z_index = 10
	Transition_out()


func _on_Timer5_timeout():
	canAdvance = true


func _on_Timer8_timeout():
	progress = 2
