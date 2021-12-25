extends KinematicBody2D

const Grav = 10
const Floor = Vector2(0, -1)
var Direction = 1
const Ammo = preload("res://HomingRocket.tscn")
var FS = 1
var Player_Detected = false
var velocity = Vector2()
var Dead = false
var Is_Attacking = false
onready var player = get_node("../Player1")

onready var global_vars = get_node("/root/global_variables")
var achievement = preload("res://Placeholder Textures for Shards of the Past/achievements/going_ballistic_card.png")

onready var me = self
var HP = 4
var can_change_anim = true
var taloned = false

func hurt(amount):
	$AnimatedSprite.play("hurt") 
	HP -= amount
	
func dead():
	Dead = true
	if taloned == true:
		if get_parent().get_node("Player1").HP < global_vars.maxHP:
			get_parent().get_node("Player1").HP += 1
	velocity = Vector2(0,0)
	$AnimatedSprite.play("dead") 
	$Timer.start()
	global_vars.srlBeaten = true
	if global_vars.srlAmount <= 0:
		get_node("../Player1").achievement_recieved(achievement)
	global_vars.srlAmount = 1
	
func leave_player_head():
	velocity.x = -70
	velocity.y = -70
	
func fire():
	$AnimatedSprite.play("ready")
	Is_Attacking = true
	velocity.x = 0
	var ammo = Ammo.instance()
	get_parent().add_child(ammo)
	ammo.position = $Position2D.global_position
	$Timer2.start()
	$Timer3.start()
	if Direction == 1:
		get_parent().get_node("Rocket").set_fireball_direction(1)
	elif Direction == -1:
		get_parent().get_node("Rocket").set_fireball_direction(-1)
	
func _physics_process(delta): 
	if Dead == false:
		if HP <= 0:
			dead()
		if Is_Attacking == true:
			if can_change_anim == true:
				$AnimatedSprite.play("ready") 
		else:
			$AnimatedSprite.play("idle")
		velocity.y += Grav
		velocity = move_and_slide(velocity, Floor)
		if Player_Detected == true:
			if Is_Attacking == false:
				fire()
		else: 
			pass
	if get_parent().get_node("PlayerVarHolder").PlayerAlive == true:
		if get_parent().get_node("Player1").position.x < self.position.x:
			Direction = -1
			$AnimatedSprite.flip_h = true
			$Position2D.position.x = -14
			FS = -1
		elif get_parent().get_node("Player1").position.x > self.position.x:
			Direction = 1
			$AnimatedSprite.flip_h = false
			$Position2D.position.x = 14
			FS = 1
	if Direction == 1:
		$AnimatedSprite.flip_h = false
		$Position2D.position.x = 14
		FS = 1
	else:
		$AnimatedSprite.flip_h = true
		$Position2D.position.x = -14
		FS = -1



func _on_Timer_timeout():
	queue_free()


func _on_Area2D_body_entered(body):
	if body.name == "Player1":
		Player_Detected = true


func _on_Area2D_body_exited(body):
	if body.name == "Player1":
		Player_Detected = false


func _on_Timer2_timeout():
	Is_Attacking = false
	can_change_anim = true
	$AnimatedSprite.play("ready")


func _on_Timer3_timeout():
	can_change_anim = false
	$AnimatedSprite.play("idle")
