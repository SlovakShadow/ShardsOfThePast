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
onready var spider = get_node("../Spider")
onready var snake = get_node("../Snake")
onready var bat = get_node("../Bat")
onready var qs = get_node("../Quantum Slayer")
var grav_flip = 0
var Is_Climbing = false
var Timer3Running = false
var wasFlipped = false
var flippedRecently = false

func dead():
	Dead = true
	velocity = Vector2(0,0)
	$AnimatedSprite.play("dead") 
	$CollisionShape2D.disabled = true 
	$Timer.start()
	
func leave_player_head():
	velocity.x = -70
	velocity.y = -30
	
func _physics_process(delta):
	if Dead == false:
		if Is_Attacking == false:
			if $RayCast2D.is_colliding() == true:
				if wasFlipped == false:
					if int(rand_range(1,3)) == 2:
						grav_flip = 1
						velocity.x = Speed * Direction
						velocity.y = Grav * -2
						Is_Climbing = true
						if Timer3Running == false:
							$Timer3.start()
							Timer3Running = true
						wasFlipped = true
						$AnimatedSprite.play("idle")
					else:
						Direction = Direction * -1
						FS = FS * -1
						flippedRecently = true
						$Timer4.start()
			elif $RayCast2D_2.is_colliding() == true:
				if wasFlipped == false:
					if int(rand_range(1,3)) == 2:
						grav_flip = 2
						velocity.x = Speed * Direction
						velocity.y = Grav * -2
						Is_Climbing = true
						if Timer3Running == false:
							$Timer3.start()
							Timer3Running = true
						wasFlipped = true
						$AnimatedSprite.play("idle")
					else:
						Direction = Direction * -1
						FS = FS * -1
						flippedRecently = true
						$Timer4.start()
			else:
				if Is_Climbing == false:
					wasFlipped = false
					grav_flip = 0
					velocity.x = Speed * Direction
					velocity.y = velocity.y + Grav
					$AnimatedSprite.play("walk") 
		else:
			velocity.x = 0
			$AnimatedSprite.play("maul") 
		if grav_flip == 0:
			velocity = move_and_slide(velocity, Floor)
		elif grav_flip == 1:
			velocity = move_and_slide(velocity, WallRight)
		elif grav_flip == 2:
			velocity = move_and_slide(velocity, WallLeft)
		#if is_on_wall():
			#if $RayCast2D2.is_colliding() == true:
				#if $RayCast2D.is_colliding() == true:
					#if WallDirection == 0:
						#self.set_rotation_degrees(-90)
						#ReverseFlipH = true
						#WallDirection = 1
					#elif WallDirection == 1:
						#self.set_rotation_degrees(-180)
						#ReverseFlipH = false
						#WallDirection = 2
					#elif WallDirection == 2:
						#self.set_rotation_degrees(-270)
						#ReverseFlipH = true
						#WallDirection = 3
					#elif WallDirection == 3:
						#self.set_rotation_degrees(0)
						#ReverseFlipH = false
						#WallDirection = 0 
			#if is_on_wall():
				#Direction = Direction * -1
				#FS = FS * -1
			
	if Direction == 1:
		if ReverseFlipH == true:
			$AnimatedSprite.flip_h = true
			$"Area2D - Hurt Area".position.x = 12
		else:
			$AnimatedSprite.flip_h = false
			$"Area2D - Hurt Area".position.x = -12
	else:
		if ReverseFlipH == true:
			$AnimatedSprite.flip_h = false
			$"Area2D - Hurt Area".position.x = -12
		else:
			$AnimatedSprite.flip_h = true
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
		body.hurt(3)
		$Timer2.start()


func _on_Timer3_timeout():
	Is_Climbing = false
	Timer3Running = false


func _on_Timer4_timeout():
	flippedRecently = false
