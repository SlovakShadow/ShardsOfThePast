extends KinematicBody2D

const Grav = 10
const Speed = 75
const Floor = Vector2(0, -1)
const WallRight = Vector2(-1, 0)
const Ceiling = Vector2(0, 1)
const WallLeft = Vector2(1, 0)
var Direction = 1
var Is_Attacking = false
var FS = 1
var Player_Detected = false
var WallDirection = 0
var velocity = Vector2()
var Dead = false
var ReverseFlipH = false
onready var player = get_node("../Player1")
const JumpPower = -125
var HP = 3
var taloned = false
onready var global_vars = get_node("/root/global_variables")

func dead():
	Dead = true
	if taloned == true:
		if get_parent().get_node("Player1").HP < global_vars.maxHP:
			get_parent().get_node("Player1").HP += 1
	velocity = Vector2(0,0)
	$AnimatedSprite.play("hurt") 
	$Timer.start()
	
func hurt(amount):
	HP = HP - amount
	if HP <= 0:
		dead()
	$AnimatedSprite.play("hurt") 
	
func leave_player_head():
	velocity.x = -70
	velocity.y = -70
	
func _physics_process(delta):
	if Dead == false:
		if Is_Attacking == false:
			velocity.x = Speed * Direction
			$AnimatedSprite.play("walk") 
		else:
			$AnimatedSprite.play("attack") 
		velocity.y += Grav
		velocity = move_and_slide(velocity, Floor)
		if is_on_wall():
			Direction = Direction * -1
			FS = FS * -1
			
	if Direction == 1:
		if ReverseFlipH == true:
			$AnimatedSprite.flip_h = true
			$Sprite.flip_h = true
			$"Area2D - Hurt Area".position.x = 12
		else:
			$AnimatedSprite.flip_h = false
			$Sprite.flip_h = false
			$"Area2D - Hurt Area".position.x = -12
	else:
		if ReverseFlipH == true:
			$AnimatedSprite.flip_h = false
			$Sprite.flip_h = false
			$"Area2D - Hurt Area".position.x = -12
		else:
			$AnimatedSprite.flip_h = true
			$Sprite.flip_h = true
			$"Area2D - Hurt Area".position.x = 12

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


func _on_Area2D__Hurt_Area_body_entered(body):
	if body.name == "Player1":
		Is_Attacking = true
		body.hurt(2)
		$Timer2.start()


func _on_TimerFall_timeout():
	WallDirection = WallDirection -1
