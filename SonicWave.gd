extends Area2D

const Speed = 100
var velocity = Vector2()
var Direction = -1

func set_ammo_direction(dir):
	Direction = dir
	if dir == 1:
		$Sprite.flip_h = true
	else:
		$Sprite.flip_h = false

func _physics_process(delta):
	velocity.x = Speed * delta * Direction
	velocity.y = velocity.y
	translate(velocity)
	


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	
func _on_Fireball_body_entered(body):
	#if "SoldierEnemy" in body.name:
	#	body.dead()
	if "Player1" in body.name:
		body.hurt(3)
		pass
	if "Leviathan" in body.name:
		pass
	if "SonicWave" in body.name:
		pass
	else:
		queue_free()
