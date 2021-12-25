extends KinematicBody2D
var Grav = 10
var Speed = 100
const Floor = Vector2(0, -1)
var Direction = 1
var Health = 12
var DetectsPlayer = 0
const JumpPower = -400
onready var player = get_node("../Player1")
onready var slayer = get_node ("../Quantum Slayer")
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
var slayer_full = preload("res://Placeholder Textures for Shards of the Past/quantumslayer_healthbar/quantumslayer_healthbar_full.png")
var slayer_5 = preload("res://Placeholder Textures for Shards of the Past/quantumslayer_healthbar/quantumslayer_healthbar_5.png")
var slayer_4 = preload("res://Placeholder Textures for Shards of the Past/quantumslayer_healthbar/quantumslayer_healthbar_4.png")
var slayer_3 = preload("res://Placeholder Textures for Shards of the Past/quantumslayer_healthbar/quantumslayer_healthbar_3.png")
var slayer_2 = preload("res://Placeholder Textures for Shards of the Past/quantumslayer_healthbar/quantumslayer_healthbar_2.png")
var slayer_1 = preload("res://Placeholder Textures for Shards of the Past/quantumslayer_healthbar/quantumslayer_healthbar_1.png")
var slayer_dead = preload("res://Placeholder Textures for Shards of the Past/quantumslayer_healthbar/quantumslayer_healthbar_dead.png")
var can_slash = true
var leaving_player_head = false
var can_turn = true

func dead():
	Dead = true
	velocity = Vector2(0,0)
	$AnimatedSprite.play("hurt") 
	$CollisionShape2D.disabled = true 
	$CollisionShape2D2.disabled = true 
	get_parent().get_node("Wall").position.y = 9999999
	
	
func hurt(amount):
	if Is_Attacking == false:
		Health -= amount
	if Health < 1:
		dead()
	$AnimatedSprite.play("hurt") 
		
func slash():
	if can_slash == true:
		if Is_Attacking == false:
			Is_Attacking = true
			player.hurt(2)
			can_slash = false
			$AnimatedSprite.play("slash")
			$Timer.start()
			$Timer6.start()
			$Timer8.start()
			can_turn = false
			Direction = Direction * -1

func leave_player_head():
	velocity.x = -70
	leaving_player_head = true
	$Timer7.start()
	

func stomp():
	if Is_Attacking == true:
		can_stomp = false
		velocity.y = JumpPower
		on_ground = false
		velocity.y = velocity.y + Grav
		$AnimatedSprite.play("jump")
		$Timer2.start()
		$Timer3.start()
		$Timer5.start()

func _physics_process(delta):
	if leaving_player_head == false:
		if on_ground == true:
			Grav = 10
		if Dead == false:
			if behave_normally == true:
				if Health == 12:
					get_parent().get_node("Player1").get_node("MarginContainer/HBoxContainer/Boss_HB").set_texture(slayer_full)
				elif Health == 10:
					get_parent().get_node("Player1").get_node("MarginContainer/HBoxContainer/Boss_HB").set_texture(slayer_5)
				elif Health == 8:
					get_parent().get_node("Player1").get_node("MarginContainer/HBoxContainer/Boss_HB").set_texture(slayer_4)
				elif Health == 6:
					get_parent().get_node("Player1").get_node("MarginContainer/HBoxContainer/Boss_HB").set_texture(slayer_3)
				elif Health == 4:
					get_parent().get_node("Player1").get_node("MarginContainer/HBoxContainer/Boss_HB").set_texture(slayer_2)
				elif Health == 2:
					get_parent().get_node("Player1").get_node("MarginContainer/HBoxContainer/Boss_HB").set_texture(slayer_1)
				elif Health == 0:
					get_parent().get_node("Player1").get_node("MarginContainer/HBoxContainer/Boss_HB").set_texture(slayer_dead)
				if get_parent().get_node("PlayerVarHolder").PlayerAlive == true:
					if can_turn == true:
						if player.position.x < slayer.position.x:
							Direction = -1
						else:
							Direction = 1
				if Player_Detected == true:
					slash()
				elif Player_Detected == false:
					if get_parent().get_node("PlayerVarHolder").PlayerAlive == true:
						if can_turn == true:
							if player.position.x < slayer.position.x:
								Direction = -1
							else:
								Direction = 1
					velocity.x = Speed * Direction
					$AnimatedSprite.play("walk") 
					velocity.y += Grav
					velocity = move_and_slide(velocity, Floor)
					if is_on_wall():
						Direction = Direction * -1
				#if Input.is_action_just_pressed("fierygoliath_shoot"):
			else:
				velocity.x = 0
				$AnimatedSprite.play("idle") 
			
	if Direction == 1:
		$AnimatedSprite.flip_h = true
		$Position2D.position.x = 17
		FS = 1
		$Area2D.position.x = 1
	else:
		$AnimatedSprite.flip_h = false
		$Position2D.position.x = -17
		FS = -1
		$Area2D.position.x = -50
	
	if Health == 0:
		dead()
		
	if is_on_floor():
		on_ground = true
	else:
		on_ground = false
		if velocity.y < 0:
			$AnimatedSprite.play("jump")
		else:
			$AnimatedSprite.play("stomp") 
		
func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "spit_prep":
		Is_Attacking = false


func _on_Area2D_body_entered(body):
	if "Player1" in body.name:
		Player_Detected = true


func _on_Timer_timeout():
	Is_Attacking = false


func _on_Timer2_timeout():
	get_parent().get_node("ScreenShake").screen_shake(1, 10, 100)


func _on_Timer3_timeout():
	$AnimatedSprite.play("stomp")


func _on_Timer4_timeout():
	stomp()
	can_stomp = true


func _on_Timer5_timeout():
	Is_Attacking = false


func _on_Timer6_timeout():
	can_slash = true


func _on_Area2D_Cave_body_entered(body):
	if "Player1" in body.name:
		behave_normally = true


func _on_Area2D_body_exited(body):
	if "Player1" in body.name:
		Player_Detected = false



func _on_Timer7_timeout():
	leaving_player_head = false


func _on_Timer8_timeout():
	can_turn = true
