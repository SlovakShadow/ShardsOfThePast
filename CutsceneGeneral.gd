extends KinematicBody2D

const Grav = 10
const Speed = 40
const Floor = Vector2(0, -1)
var Direction = 1
var Is_Attacking = false
const Ammo = preload("res://Dart.tscn")
var FS = -1
var Player_Detected = false
var HP = 2
var velocity = Vector2()
var Dead = false
onready var global_vars = get_node("/root/global_variables")
var taloned = false
var walking = true
var shoot = true

func hurt():
	HP = HP - 1

func dead():
	if taloned == true:
		if get_parent().get_node("Player1").HP < global_vars.maxHP:
			get_parent().get_node("Player1").HP += 1
	Dead = true
	velocity = Vector2(0,0)
	$AnimatedSprite.play("dead") 
	$Timer.start()
	
func leave_player_head():
	velocity.x = -70
	velocity.y = -70
	
func fire():
	Is_Attacking = true
	velocity.x = 0
	var ammo = Ammo.instance()
	if FS == 1:
		ammo.set_ammo_direction(1)
	else:
		ammo.set_ammo_direction(-1)
	get_parent().add_child(ammo)
	ammo.position = $Position2D.global_position
	$AnimatedSprite.play("attack")
	$Timer2.start()
	
func _physics_process(delta):
	if global_variables.currentCutscene == 2:
		velocity.y += Grav
		if walking == true:
			velocity.x = -Speed
			$AnimatedSprite.play("walk") 
			$Timer.start()
			move_and_slide(velocity, Floor)
		elif walking == false:
			velocity.x = 0
			move_and_slide(velocity, Floor)




func _on_Timer_timeout():
	walking = false


func _on_Area2D_body_entered(body):
	if body.name == "PlayerCutscene2":
		if shoot == true:
			walking = false
			velocity.x = 0
			shoot = false
			fire()


func _on_Area2D_body_exited(body):
	if body.name == "Player1":
		Player_Detected = false


func _on_Timer2_timeout():
	Is_Attacking = false



func _on_Area2D2_body_entered(body):
	if body.name == "PlayerCutscene2":
		if global_variables.currentCutscene == 2:
			get_node("../PlayerCutscene2").dialoguePart = 22
