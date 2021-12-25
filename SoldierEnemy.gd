extends KinematicBody2D

const Grav = 10
const Speed = 40
const Floor = Vector2(0, -1)
var Direction = 1
var Is_Attacking = false
const Ammo = preload("res://Ammo.tscn")
var FS = 1
var Player_Detected = false
var HP = 2
var velocity = Vector2()
var Dead = false
onready var global_vars = get_node("/root/global_variables")
var taloned = false

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
	if Dead == false:
		if HP <= 0:
			dead()
		if Is_Attacking == false:
			velocity.x = Speed * Direction
			$AnimatedSprite.play("walk") 
		else:
			velocity.x = 0
			$AnimatedSprite.play("attack") 
		velocity.y += Grav
		velocity = move_and_slide(velocity, Floor)
		if is_on_wall():
			Direction = Direction * -1
			FS = FS * -1
			$RayCast2D.position.x *= -1
			
		if Player_Detected == true:
			if Is_Attacking == false:
				fire()
		else: 
			pass
	if get_parent().get_node("PlayerVarHolder").PlayerAlive == true:
		if get_parent().get_node("Player1").position.x < self.position.x:
			Direction = -1
			FS = -1
		else:
			Direction = 1
			FS = 1
  
	if $RayCast2D.is_colliding() == false:
		Direction = Direction * -1
		FS = FS * -1
		$RayCast2D.position.x *= -1
	if Direction == 1:
		$AnimatedSprite.flip_h = false
		$Position2D.position.x = 13
	else:
		$AnimatedSprite.flip_h = true
		$Position2D.position.x = -13



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
