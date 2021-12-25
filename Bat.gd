extends KinematicBody2D

const Grav = 3
var Fly = 200
const Speed = 75
const Floor = Vector2(0, -1)
var Direction = 1
var Is_Attacking = false
var FS = 1
var Player_Detected = false
var NegativeGrav = 0
var velocity = Vector2()
var Dead = false
onready var player = get_node("../Player1")
var Player_Offset = 0
var CanPlayAttackAnimation = true
var taloned = false
onready var global_vars = get_node("/root/global_variables")


func dead():
	Dead = true
	if taloned == true:
		if get_parent().get_node("Player1").HP < global_vars.maxHP:
			get_parent().get_node("Player1").HP += 1
	velocity = Vector2(0,0)
	$AnimatedSprite.play("hurt") 
	$CollisionShape2D.disabled = true 
	$Timer.start()
	
func leave_player_head():
	velocity.x = -70
	velocity.y = -70
	
func _physics_process(delta):
	if Dead == false:
		#if player.position.x < self.position.x:
		#	Direction = -1
		#else:
		#		Direction = 1
		if Is_Attacking == false:
			velocity.x = Speed * Direction
			$AnimatedSprite.play("flight") 
		else:
			if CanPlayAttackAnimation == true:
				$AnimatedSprite.play("attack") 
				CanPlayAttackAnimation = false
			else:
				pass
		Fly = randi()%201+1
		if NegativeGrav == 0:
			velocity.y = (velocity.y + Fly) / Grav 
		else:
			velocity.y = (velocity.y + Fly) / (Grav * -1)
		if is_on_floor() == true:
			velocity.y = (velocity.y + Fly) / (Grav * -1)
			NegativeGrav = 1
		velocity = move_and_slide(velocity, Floor)
		#velocity = position.direction_to(player.position) * Speed
		if is_on_wall():
			Direction = Direction * -1
			FS = FS * -1
			
	if Direction == 1:
		$AnimatedSprite.flip_h = true
		$"Area2D - Hurt Area".position.x = 10
	else:
		$AnimatedSprite.flip_h = false
		$"Area2D - Hurt Area".position.x = -10



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


func _on_Timer3_timeout():
	NegativeGrav = randi()%2+0


func _on_Area2D__Hurt_Area_body_entered(body):
	if body.name == "Player1":
		Is_Attacking = true
		CanPlayAttackAnimation = true
		body.hurt(3)
		$Timer2.start()
