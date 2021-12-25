extends Area2D

const Speed = 120
var velocity =Vector2()
var Direction = 1
var exploding = false

func set_fireball_direction(dir):
	Direction = dir
	if dir == -1:
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.flip_h = false

func _physics_process(delta):
	if exploding == false:
		velocity.x = Speed * delta * Direction
		translate(velocity)
		$AnimatedSprite.play("shoot")
	


func _on_VisibilityNotifier2D_screen_exited():
	#queue_free()
	pass
	
func _on_Fireball_body_entered(body):
	exploding = true
	if "SoldierEnemy" in body.name:
		body.hurt(2)
	elif "Fiery Goliath" in body.name:
		body.hurt(1)
	elif "Quantum Slayer" in body.name:
		body.hurt(1)
	elif "Snake" in body.name:
		body.hurt(2)
	elif "Bat" in body.name:
		body.dead()
	elif "Dummy" in body.name:
		body.hurt(1)
	elif "Tumbleblade" in body.name:
		body.hurt(1)
	elif "Blighteye" in body.name:
		body.hurt(1)
	elif "Blightspitter" in body.name:
		body.hurt(1)
	elif "Blightpack" in body.name:
		body.hurt(1)
	elif "Blightmother" in body.name:
		body.hurt(1)
	elif "Boomba" in body.name:
		body.hurt(1)
	elif "Shooting Roomba" in body.name:
		body.hurt(1)
	elif "Breachling" in body.name:
		body.hurt(1)
	elif "Leviathan" in body.name:
		body.hurt(1)
	velocity = 0
	$Trail.emitting = false
	$Trail.visible = false
	$AnimatedSprite.visible = true
	$Explosion.emitting = true
	$Timer.start()


func _on_Timer_timeout():
	queue_free()
