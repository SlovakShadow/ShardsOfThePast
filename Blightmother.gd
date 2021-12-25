extends KinematicBody2D

var canHurt = true
var HP = 8
var dead = false
var achievement = preload("res://Placeholder Textures for Shards of the Past/achievements/eyeronic_card.png")
onready var global_vars = get_node("/root/global_variables")
var taloned = false

func hurt(amount):
	if get_node("../Player1/MarginContainer/HBoxContainer/Boss_HB_2").texture == get_node("../Player1").blightpack_0_4:
		if HP > 0:
			HP -= amount
		if HP <= 0:
			if dead == false:
				dead()
				dead = true

func dead():
	if taloned == true:
		if get_parent().get_node("Player1").HP < global_vars.maxHP:
			get_parent().get_node("Player1").HP += 1
	$AnimatedSprite.play("dying")
	$Area2D/CollisionShape2D.disabled = true
	$CollisionShape2D.disabled = true
	$CollisionPolygon2D.disabled = true
	$Timer3.start()
	global_vars.maxHP = global_vars.maxHP + 1
	global_vars.blightmotherBeaten = true
	get_node("../Player1").ready_HP()
	get_node("../Player1").achievement_recieved(achievement)
	get_node("../Player1").in_or_out = 1
	global_variables.unlock_sprite = 2
	get_node("../Player1/Timer16").start()

func _ready():
	pass


func _process(delta):
	if dead == false:
		if get_node("../Player1/MarginContainer/HBoxContainer/Boss_HB_2").texture == get_node("../Player1").blightpack_0_4:
			pass
		if HP == 8:
			get_node("../Player1/MarginContainer/HBoxContainer/Boss_HB").set_texture(get_node("../Player1").blightmother_full)
		elif HP == 7:
			get_node("../Player1/MarginContainer/HBoxContainer/Boss_HB").set_texture(get_node("../Player1").blightmother_7_8)
		elif HP == 6:
			get_node("../Player1/MarginContainer/HBoxContainer/Boss_HB").set_texture(get_node("../Player1").blightmother_6_8)
		elif HP == 5:
			get_node("../Player1/MarginContainer/HBoxContainer/Boss_HB").set_texture(get_node("../Player1").blightmother_5_8)
		elif HP == 4:
			get_node("../Player1/MarginContainer/HBoxContainer/Boss_HB").set_texture(get_node("../Player1").blightmother_4_8)
		elif HP == 3:
			get_node("../Player1/MarginContainer/HBoxContainer/Boss_HB").set_texture(get_node("../Player1").blightmother_3_8)
		elif HP == 2:
			get_node("../Player1/MarginContainer/HBoxContainer/Boss_HB").set_texture(get_node("../Player1").blightmother_2_8)
		elif HP == 1:
			get_node("../Player1/MarginContainer/HBoxContainer/Boss_HB").set_texture(get_node("../Player1").blightmother_1_8)
		elif HP <= 0:
			dead()
			dead = true
			get_node("../Player1/MarginContainer/HBoxContainer/Boss_HB").set_texture(get_node("../Player1").blightmother_0_8)

func _on_Area2D_body_entered(body):
	if dead == false:
		if canHurt == true:
			if body.name == "Player1":
				body.hurt(3)
				canHurt = false
				$Timer.start()


func _on_Timer_timeout():
	canHurt = true


func _on_Timer2_timeout():
	$Timer2.start()
	$AnimatedSprite.play("dead")
	$AnimatedSprite.modulate.a -= 0.05
	if $AnimatedSprite.modulate.a <= 0:
		queue_free()


func _on_Timer3_timeout():
	$Timer2.start()
