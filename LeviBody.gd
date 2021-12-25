extends KinematicBody2D

var dead = false
var HP = 24
var taloned = false
var achievement = preload("res://Placeholder Textures for Shards of the Past/achievements/squidgame_card.png")
var sonicWaveTimer = 0
const SonicWave = preload("res://SonicWave.tscn")
var move = true
#var offset = 0


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func hurt(amount):
	if HP > 0:
		HP -= amount
	if HP <= 0:
		if dead == false:
			dead()
			dead = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	

func sonicWave():
	$Leviathan/AnimatedSprite.play("minibreach")
#	var Gunshot = gunshot.instance()
	var ammo1 = SonicWave.instance()
	var ammo2 = SonicWave.instance()
	ammo1.set_ammo_direction(-1)
	ammo2.set_ammo_direction(1)
	get_parent().add_child(ammo1)
	ammo1.position = $Leviathan/Position2D.global_position
	get_parent().add_child(ammo2)
	ammo2.position = $Leviathan/Position2D2.global_position
#	get_parent().add_child(Gunshot)
#	Gunshot.position = $Position2D.global_position
#	Gunshot.stream = shoot_noise
#	$AudioStreamPlayer2D.stop()
#	$AudioStreamPlayer2D.stream = shoot_noise
#	$Timer2.start()

func dead():
	if taloned == true:
		if get_parent().get_node("Player1").HP < global_variables.maxHP:
			get_parent().get_node("Player1").HP += 1
	$AnimatedSprite.play("dying")
#	$Area2D/CollisionShape2D.disabled = true
	$CollisionShape2D.disabled = true
#	$Timer3.start()
	global_variables.maxHP = global_variables.maxHP + 2
	global_variables.leviathanBeaten = true
	get_node("/root/TheBreachLevel10/Player1").ready_HP()
	get_node("/root/TheBreachLevel10/Player1").achievement_recieved(achievement)

func _physics_process(delta):
	if dead == false:
		if move == true:
			$"../Leviathan".set_offset(offset+1)
		if offset > 360:
			if offset < 380:
				move = false
				$SonicWaveTimer.start()
		if HP == 24:
			get_node("/root/TheBreachLevel10/Player1/MarginContainer/HBoxContainer/Boss_HB").set_texture(get_node("/root/TheBreachLevel10/Player1").leviathan_24)
		elif HP == 23:
			get_node("/root/TheBreachLevel10/Player1/MarginContainer/HBoxContainer/Boss_HB").set_texture(get_node("/root/TheBreachLevel10/Player1").leviathan_23)
		elif HP == 22:
			get_node("/root/TheBreachLevel10/Player1/MarginContainer/HBoxContainer/Boss_HB").set_texture(get_node("/root/TheBreachLevel10/Player1").leviathan_22)
		elif HP == 21:
			get_node("/root/TheBreachLevel10/Player1/MarginContainer/HBoxContainer/Boss_HB").set_texture(get_node("/root/TheBreachLevel10/Player1").leviathan_21)
		elif HP == 20:
			get_node("/root/TheBreachLevel10/Player1/MarginContainer/HBoxContainer/Boss_HB").set_texture(get_node("/root/TheBreachLevel10/Player1").leviathan_20)
		elif HP == 19:
			get_node("/root/TheBreachLevel10/Player1/MarginContainer/HBoxContainer/Boss_HB").set_texture(get_node("/root/TheBreachLevel10/Player1").leviathan_19)
		elif HP == 18:
			get_node("/root/TheBreachLevel10/Player1/MarginContainer/HBoxContainer/Boss_HB").set_texture(get_node("/root/TheBreachLevel10/Player1").leviathan_18)
		elif HP == 17:
			get_node("/root/TheBreachLevel10/Player1/MarginContainer/HBoxContainer/Boss_HB").set_texture(get_node("/root/TheBreachLevel10/Player1").leviathan_17)
		elif HP == 16:
			get_node("/root/TheBreachLevel10/Player1/MarginContainer/HBoxContainer/Boss_HB").set_texture(get_node("/root/TheBreachLevel10/Player1").leviathan_16)
		elif HP == 15:
			get_node("/root/TheBreachLevel10/Player1/MarginContainer/HBoxContainer/Boss_HB").set_texture(get_node("/root/TheBreachLevel10/Player1").leviathan_15)
		elif HP == 14:
			get_node("/root/TheBreachLevel10/Player1/MarginContainer/HBoxContainer/Boss_HB").set_texture(get_node("/root/TheBreachLevel10/Player1").leviathan_14)
		elif HP == 13:
			get_node("/root/TheBreachLevel10/Player1/MarginContainer/HBoxContainer/Boss_HB").set_texture(get_node("/root/TheBreachLevel10/Player1").leviathan_13)
		elif HP == 12:
			get_node("/root/TheBreachLevel10/Player1/MarginContainer/HBoxContainer/Boss_HB").set_texture(get_node("/root/TheBreachLevel10/Player1").leviathan_12)
		elif HP == 11:
			get_node("/root/TheBreachLevel10/Player1/MarginContainer/HBoxContainer/Boss_HB").set_texture(get_node("/root/TheBreachLevel10/Player1").leviathan_11)
		elif HP == 10:
			get_node("/root/TheBreachLevel10/Player1/MarginContainer/HBoxContainer/Boss_HB").set_texture(get_node("/root/TheBreachLevel10/Player1").leviathan_10)
		elif HP == 9:
			get_node("/root/TheBreachLevel10/Player1/MarginContainer/HBoxContainer/Boss_HB").set_texture(get_node("/root/TheBreachLevel10/Player1").leviathan_9)
		elif HP == 8:
			get_node("/root/TheBreachLevel10/Player1/MarginContainer/HBoxContainer/Boss_HB").set_texture(get_node("/root/TheBreachLevel10/Player1").leviathan_8)
		elif HP == 7:
			get_node("/root/TheBreachLevel10/Player1/MarginContainer/HBoxContainer/Boss_HB").set_texture(get_node("/root/TheBreachLevel10/Player1").leviathan_7)
		elif HP == 6:
			get_node("/root/TheBreachLevel10/Player1/MarginContainer/HBoxContainer/Boss_HB").set_texture(get_node("/root/TheBreachLevel10/Player1").leviathan_6)
		elif HP == 5:
			get_node("/root/TheBreachLevel10/Player1/MarginContainer/HBoxContainer/Boss_HB").set_texture(get_node("/root/TheBreachLevel10/Player1").leviathan_5)
		elif HP == 4:
			get_node("/root/TheBreachLevel10/Player1/MarginContainer/HBoxContainer/Boss_HB").set_texture(get_node("/root/TheBreachLevel10/Player1").leviathan_4)
		elif HP == 3:
			get_node("/root/TheBreachLevel10/Player1/MarginContainer/HBoxContainer/Boss_HB").set_texture(get_node("/root/TheBreachLevel10/Player1").leviathan_3)
		elif HP == 2:
			get_node("/root/TheBreachLevel10/Player1/MarginContainer/HBoxContainer/Boss_HB").set_texture(get_node("/root/TheBreachLevel10/Player1").leviathan_2)
		elif HP == 1:
			get_node("/root/TheBreachLevel10/Player1/MarginContainer/HBoxContainer/Boss_HB").set_texture(get_node("/root/TheBreachLevel10/Player1").leviathan_1)
		elif HP <= 0:
			get_node("/root/TheBreachLevel10/Player1/MarginContainer/HBoxContainer/Boss_HB").set_texture(get_node("/root/TheBreachLevel10/Player1").leviathan_0)
			dead()
			dead = true


func _on_SonicWaveTimer_timeout():
	if sonicWaveTimer == 0:
		sonicWaveTimer = 1
		$Leviathan/AnimatedSprite.play("minibreach")
#		var Gunshot = gunshot.instance()
		var ammo1 = SonicWave.instance()
		var ammo2 = SonicWave.instance()
		ammo1.set_ammo_direction(-1)
		ammo2.set_ammo_direction(1)
		get_parent().add_child(ammo1)
		ammo1.position = $Leviathan/Position2D.global_position
		get_parent().add_child(ammo2)
		ammo2.position = $Leviathan/Position2D2.global_position
		$SonicWaveTimer.start()
	elif sonicWaveTimer == 1:
		sonicWaveTimer = 2
		$Leviathan/AnimatedSprite.play("minibreach")
#		var Gunshot = gunshot.instance()
		var ammo1 = SonicWave.instance()
		var ammo2 = SonicWave.instance()
		ammo1.set_ammo_direction(-1)
		ammo2.set_ammo_direction(1)
		get_parent().add_child(ammo1)
		ammo1.position = $Leviathan/Position2D.global_position
		get_parent().add_child(ammo2)
		ammo2.position = $Leviathan/Position2D2.global_position
		$SonicWaveTimer.start()
	elif sonicWaveTimer == 2:
		sonicWaveTimer = 3
		$Leviathan/AnimatedSprite.play("minibreach")
#		var Gunshot = gunshot.instance()
		var ammo1 = SonicWave.instance()
		var ammo2 = SonicWave.instance()
		ammo1.set_ammo_direction(-1)
		ammo2.set_ammo_direction(1)
		get_parent().add_child(ammo1)
		ammo1.position = $Leviathan/Position2D.global_position
		get_parent().add_child(ammo2)
		ammo2.position = $Leviathan/Position2D2.global_position
		$SonicWaveTimer.start()
	elif sonicWaveTimer == 3:
		sonicWaveTimer = 4
		$Leviathan/AnimatedSprite.play("minibreach")
#		var Gunshot = gunshot.instance()
		var ammo1 = SonicWave.instance()
		var ammo2 = SonicWave.instance()
		ammo1.set_ammo_direction(-1)
		ammo2.set_ammo_direction(1)
		get_parent().add_child(ammo1)
		ammo1.position = $Leviathan/Position2D.global_position
		get_parent().add_child(ammo2)
		ammo2.position = $Leviathan/Position2D2.global_position
		$SonicWaveTimer.start()
	elif sonicWaveTimer == 4:
		move = true
