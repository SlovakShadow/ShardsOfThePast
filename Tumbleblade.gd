extends KinematicBody2D

var HP = 12
var charge = false
var velocity = Vector2.ZERO
var attack_speed = 150
var speed = 100
var attacking = false
var Direction = 1
const Floor = Vector2(0, -1)
var Grav = 70
var alive = true
onready var global_vars = get_node("/root/global_variables")

const gunshot = preload("res://sfx_tumbleblade_charge.tscn")
const noise = preload("res://sfx_tumbleblade_ambient.tscn")

var tumbleblade_full = preload("res://Placeholder Textures for Shards of the Past/tumbleblade/tumbleblade_healthbar_full.png")
var tumbleblade_5_6 = preload("res://Placeholder Textures for Shards of the Past/tumbleblade/tumbleblade_healthbar_5.png")
var tumbleblade_4_6 = preload("res://Placeholder Textures for Shards of the Past/tumbleblade/tumbleblade_healthbar_4.png")
var tumbleblade_3_6 = preload("res://Placeholder Textures for Shards of the Past/tumbleblade/tumbleblade_healthbar_3.png")
var tumbleblade_2_6 = preload("res://Placeholder Textures for Shards of the Past/tumbleblade/tumbleblade_healthbar_2.png")
var tumbleblade_1_6 = preload("res://Placeholder Textures for Shards of the Past/tumbleblade/tumbleblade_healthbar_1.png")
var tumbleblade_0_6 = preload("res://Placeholder Textures for Shards of the Past/tumbleblade/tumbleblade_healthbar_0.png")

var achievement = preload("res://Placeholder Textures for Shards of the Past/achievements/fast_and_slashing_card.png")

var deadAnimFin = false
var speedymoment = false
var stopAmount = 0
var animAmount = 0
var taloned = false

func _ready():
	$Timer.start()

func hurt(amount):
	HP -= amount
	$AnimatedSprite.play("hurt")

func dead():
	if taloned == true:
		if get_parent().get_node("Player1").HP < global_vars.maxHP:
			get_parent().get_node("Player1").HP += 1
	$Area2D/CollisionShape2D.disabled = true
	$CollisionShape2D.disabled = true
	$AnimatedSprite.play("dying")
	$Timer3.start()
	global_vars.tumblebladeBeaten = true
	alive = false
	get_parent().get_node("TileMap4").position.y = 0
	global_vars.maxHP = global_vars.maxHP + 1
	get_node("../Player1").ready_HP()
	get_node("../Player1").achievement_recieved(achievement)
	get_node("../Player1/Timer14").start()
	get_node("../Player1").in_or_out = 1
	global_variables.unlock_sprite = 1
	get_node("../Player1/Timer16").start()


func _physics_process(delta):
	if HP == 12:
		get_parent().get_node("Player1").get_node("MarginContainer/HBoxContainer/Boss_HB").set_texture(tumbleblade_full)
	elif HP == 10:
		get_parent().get_node("Player1").get_node("MarginContainer/HBoxContainer/Boss_HB").set_texture(tumbleblade_5_6)
	elif HP == 8:
		get_parent().get_node("Player1").get_node("MarginContainer/HBoxContainer/Boss_HB").set_texture(tumbleblade_4_6)
	elif HP == 6:
		get_parent().get_node("Player1").get_node("MarginContainer/HBoxContainer/Boss_HB").set_texture(tumbleblade_3_6)
	elif HP == 4:
		get_parent().get_node("Player1").get_node("MarginContainer/HBoxContainer/Boss_HB").set_texture(tumbleblade_2_6)
	elif HP == 2:
		get_parent().get_node("Player1").get_node("MarginContainer/HBoxContainer/Boss_HB").set_texture(tumbleblade_1_6)
	elif HP == 0:
		get_parent().get_node("Player1").get_node("MarginContainer/HBoxContainer/Boss_HB").set_texture(tumbleblade_0_6)
	if alive == true:
		if HP <= 0:
			dead()
#		if is_on_wall():
#			charge = false
#		if randi()%640+1 == 640:
#			var Noise = noise.instance()
#			get_parent().add_child(Noise)
#			Noise.position = $Position2D.global_position
		if charge == false:
			if Direction == -1:
					$AnimatedSprite.flip_h = true
			if Direction == 1:
					$AnimatedSprite.flip_h = false
			if is_on_wall():
				Direction *= -1
			if attacking == true:
				velocity.x = attack_speed * Direction
				$AnimatedSprite.play("vicious_roll")
				speedymoment = false
			else:
				$AnimatedSprite.play("roll")
				velocity.x = speed * Direction
				if animAmount < 1:
					if $AnimatedSprite.animation == "uncharge":
						animAmount += 1
				else:
					animAmount = 0
#				speedymoment = true
#				$Timer5.start()
			velocity.y = velocity.y + Grav
			velocity = move_and_slide(velocity, Floor)
		elif charge == true:
			if attacking == false:
				$AnimatedSprite.play("charge")
#				var Gunshot = gunshot.instance()
#				get_parent().add_child(Gunshot)
#				Gunshot.position = $Position2D.global_position
	elif alive == false:
		if deadAnimFin == false:
			$AnimatedSprite.play("dying")

func _on_AnimatedSprite_animation_finished():
	if charge == true:
		velocity.x = attack_speed
		attacking = true
		charge = false
		speedymoment = true
		$AnimatedSprite.play("vicious_roll")


func _on_Area2D_body_entered(body):
	if attacking == false:
		if body.name == "Player1":
			body.hurt(2)
	elif attacking == true:
		if body.name == "Player1":
			body.hurt(4)


func _on_Timer_timeout():
	if randi()%5+1 == 5:
		charge = true
		speedymoment = true
		$Timer2.start()
	$Timer.start()
	


func _on_Timer2_timeout():
	stopAmount += 1
	if stopAmount == 2:
		attacking = false
		stopAmount = 0
	$AnimatedSprite.play("uncharge")


func _on_Timer3_timeout():
	$AnimatedSprite.play("dead")
	deadAnimFin = true
	$Timer4.start()


func _on_Timer4_timeout():
	$Timer6.start()
	$Timer4.start()
	$AnimatedSprite.modulate.a -= 0.05
	if $AnimatedSprite.modulate.a <= 0:
		get_node("../Desert Arena").queue_free()
		queue_free()


func _on_Timer5_timeout():
	pass
#	var Gunshot = gunshot.instance()
#	get_parent().add_child(Gunshot)
#	Gunshot.position = $Position2D.global_position
#	if speedymoment == true:
#		$Timer5.start()


func _on_Timer6_timeout():
	$AnimatedSprite.play("dead")
	$Timer6.start()
