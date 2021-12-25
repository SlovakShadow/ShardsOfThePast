extends KinematicBody2D

const Grav = 10
const Floor = Vector2(0, -1)
var Direction = 1
const Ammo = preload("res://Firespit.tscn")
var FS = 1
var Player_Detected = false
var velocity = Vector2()
var Dead = false
var Is_Attacking = false
onready var player = get_node("../Player1")
onready var me = self
var HP = 2
var hurtanim_playing = false
var taloned = false
onready var global_vars = get_node("/root/global_variables")

func hurt(amount):
	HP = HP - amount
	$AnimatedSprite.play("hurt")
	
func dead():
	Dead = true
	if taloned == true:
		if get_parent().get_node("Player1").HP < global_vars.maxHP:
			get_parent().get_node("Player1").HP += 1
	velocity = Vector2(0,0)
	$AnimatedSprite.play("hurt")  
	$Timer.start()
	
	
func fire():
	Is_Attacking = true
	velocity.x = 0
	$AnimatedSprite.play("attack")
	var ammo = Ammo.instance()
	if FS == 1:
		ammo.set_fireball_direction(1)
	else:
		ammo.set_fireball_direction(-1)
	get_parent().add_child(ammo)
	ammo.position = $Position2D.global_position
	ammo.damage = 2
	$AnimatedSprite.play("attack")
	$Timer2.start()
	
func _physics_process(delta): 
	if Dead == false:
		if HP <= 0:
			dead()
		if Is_Attacking == true:
			$AnimatedSprite.play("attack") 
		else:
			$AnimatedSprite.play("idle")
		velocity.y += Grav
		velocity = move_and_slide(velocity, Floor)
		if is_on_wall():
			Direction = Direction * -1
			FS = FS * -1
		if Player_Detected == true:
			if Is_Attacking == false:
				fire()
		else: 
			pass
	if get_node("../PlayerVarHolder").PlayerAlive == true:
		if get_node("../Player1").position.x > self.position.x:
			Direction = -1
		elif get_node("../Player1").position.x < self.position.x:
			Direction = 1
	if Direction == -1:
		$AnimatedSprite.flip_h = true
		$Position2D.position.x = 13
		$Area2D/CollisionShape2D.position.x = 72
		FS = 1
	else:
		$AnimatedSprite.flip_h = false
		$Position2D.position.x = -13
		$Area2D/CollisionShape2D.position.x = -72
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
	$AnimatedSprite.play("attack")

