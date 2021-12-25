extends KinematicBody2D
var Grav = 10
var Speed = 40
const Floor = Vector2(0, -1)
var Direction = 1
var Health = 10
var DetectsPlayer = 0
const JumpPower = -301
onready var player = get_node("../Player1")
onready var goliath = get_node ("../Fiery Goliath")
var mode = 0
var Is_Attacking = false
var FS = 1
const Firespit = preload("res://Firespit.tscn")
var on_ground = true
var velocity = Vector2()
var Dead = false
var Player_Detected = false
var can_stomp = true
var can_spit = true
var behave_normally = false
var goliath_full = preload("res://Placeholder Textures for Shards of the Past/fierygoliath_healthbar/fierygoliath_healthbar_full.png")
var goliath_80 = preload("res://Placeholder Textures for Shards of the Past/fierygoliath_healthbar/fierygoliath_healthbar_80.png")
var goliath_60 = preload("res://Placeholder Textures for Shards of the Past/fierygoliath_healthbar/fierygoliath_healthbar_60.png")
var goliath_40 = preload("res://Placeholder Textures for Shards of the Past/fierygoliath_healthbar/fierygoliath_healthbar_40.png")
var goliath_20 = preload("res://Placeholder Textures for Shards of the Past/fierygoliath_healthbar/fierygoliath_healthbar_20.png")
var goliath_dead = preload("res://Placeholder Textures for Shards of the Past/fierygoliath_healthbar/fierygoliath_healthbar_0.png")
var grunt = 1
var grunt_1 = preload("res://sfx_goliath_grunt_1.tscn")
var grunt_2 = preload("res://sfx_goliath_grunt_2.tscn")
var grunt_3 = preload("res://sfx_goliath_grunt_3.tscn")

onready var global_vars = get_node("/root/global_variables")

var achievement = preload("res://Placeholder Textures for Shards of the Past/achievements/extinguished_card.png")

var deadAnimFin = false
var taloned = false

func dead():
	Dead = true
	if taloned == true:
		if get_parent().get_node("Player1").HP < global_vars.maxHP:
			get_parent().get_node("Player1").HP += 1
	velocity = Vector2(0,0)
	$AnimatedSprite.play("dying")
	$Timer7.start()
	$CollisionShape2D.disabled = true 
	get_node("../LabWall").position.y = 84254
	global_vars.maxHP = global_vars.maxHP + 1
	global_vars.fieryGoliathBeaten = true
	get_node("../Player1").ready_HP()
	get_node("../Player1").achievement_recieved(achievement)
	
func hurt(amount):
	if Is_Attacking == false:
		Health -= amount
	$AnimatedSprite.play("hurt") 
		
func spit():
	if Is_Attacking == true:
		can_spit = false
		var firespit = Firespit.instance()
		if FS == 1:
			firespit.set_fireball_direction(1)
		else:
			firespit.set_fireball_direction(-1)
		get_parent().add_child(firespit)
		firespit.position = $Position2D.global_position
		$Timer.start()
		$Timer6.start()

func leave_player_head():
	velocity.x = -70

#func stomp():
#	if Is_Attacking == true:
#		can_stomp = false
#		Grav = 30
#		velocity.y = JumpPower
#		on_ground = false
#		velocity.y = velocity.y + Grav
#		$AnimatedSprite.play("jump")
#		$Timer2.start()
#		$Timer3.start()
#		$Timer5.start()

func _physics_process(delta):
	if on_ground == true:
		Grav = 10
	if Dead == false:
#		if randi()%320+1 == 320:
#			grunt = randi()%3+1 
#			if grunt == 1:
#				var Noise = grunt_1.instance()
#				get_parent().add_child(Noise)
#				Noise.position = $Position2D.global_position
#			elif grunt == 2:
#				var Noise = grunt_2.instance()
#				get_parent().add_child(Noise)
#				Noise.position = $Position2D.global_position
#			elif grunt == 3:
#				var Noise = grunt_3.instance()
#				get_parent().add_child(Noise)
#				Noise.position = $Position2D.global_position
		if Health <= 0:
			dead()
		if behave_normally == true:
			if Health == 10:
				get_parent().get_node("Player1").get_node("MarginContainer/HBoxContainer/Boss_HB").set_texture(goliath_full)
			elif Health == 8:
				get_parent().get_node("Player1").get_node("MarginContainer/HBoxContainer/Boss_HB").set_texture(goliath_80)
			elif Health == 6:
				get_parent().get_node("Player1").get_node("MarginContainer/HBoxContainer/Boss_HB").set_texture(goliath_60)
			elif Health == 4:
				get_parent().get_node("Player1").get_node("MarginContainer/HBoxContainer/Boss_HB").set_texture(goliath_40)
			elif Health == 2:
				get_parent().get_node("Player1").get_node("MarginContainer/HBoxContainer/Boss_HB").set_texture(goliath_20)
			elif Health == 0:
				get_parent().get_node("Player1").get_node("MarginContainer/HBoxContainer/Boss_HB").set_texture(goliath_dead)
			if Player_Detected == true:
				if Is_Attacking == false:
					velocity.x = 0 * Direction
					Is_Attacking = true
					if can_spit == true:
						$AnimatedSprite.play("spit_prep")
						spit()
			elif Player_Detected == false:
				if get_parent().get_node("PlayerVarHolder").PlayerAlive == true:
					if player.position.x < goliath.position.x:
						Direction = -1
					else:
						Direction = 1
				velocity.x = Speed * Direction
				$AnimatedSprite.play("walk") 
				velocity.y += Grav
				velocity = move_and_slide(velocity, Floor)
				if is_on_wall():
					Direction = Direction * -1
		else:
			if Dead == false:
				velocity.x = 0
				$AnimatedSprite.play("idle") 
			elif Dead == true:
				velocity.x = 0
				if deadAnimFin == false:
					$AnimatedSprite.play("dying")
	elif Dead == true:
		if deadAnimFin == false:
			$AnimatedSprite.play("dying")
	if Direction == 1:
		$AnimatedSprite.flip_h = false
		$Position2D.position.x = 17
		FS = 1
		$Area2D/CollisionShape2D.position.x = 60
	else:
		$AnimatedSprite.flip_h = true
		$Position2D.position.x = -17
		FS = -1
		$Area2D/CollisionShape2D.position.x = -60
	
	
		
	if is_on_floor():
		on_ground = true
	else:
		on_ground = false
		if velocity.y < 0:
			$AnimatedSprite.play("jump")
#		else:
#			$AnimatedSprite.play("stomp") 
		
func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "spit_prep":
		Is_Attacking = false


func _on_Area2D_body_entered(body):
	#$Label_debug.set_text(body.name)
	if "Player1" in body.name:
		Player_Detected = true


func _on_Timer_timeout():
	Is_Attacking = false


func _on_Area2D_body_exited(body):
	if "Player1" in body.name:
		Player_Detected = false


func _on_Timer2_timeout():
	get_parent().get_node("ScreenShake").screen_shake(1, 10, 100)


#func _on_Timer3_timeout():
#	$AnimatedSprite.play("stomp")


#func _on_Timer4_timeout():
	#stomp()
	#can_stomp = true


func _on_Timer5_timeout():
	Is_Attacking = false


func _on_Timer6_timeout():
	can_spit = true


func _on_Area2D_Lab_body_entered(body):
	if "Player1" in body.name:
		behave_normally = true

func _on_Timer7_timeout():
	$AnimatedSprite.play("dead")
	deadAnimFin = true
	$Timer8.start()


func _on_Timer8_timeout():
	$Timer8.start()
	$AnimatedSprite.play("dead")
	$AnimatedSprite.modulate.a -= 0.05
	if $AnimatedSprite.modulate.a <= 0:
		queue_free()
