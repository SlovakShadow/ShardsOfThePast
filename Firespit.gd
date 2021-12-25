extends Area2D

const Speed = 150
var velocity =Vector2()
var Direction = 1
var exploding = false
var damage = 3

func set_fireball_direction(dir):
	Direction = dir
	if dir == -1:
		$AnimatedSprite2.flip_h = true
	else:
		$AnimatedSprite2.flip_h = false

func _physics_process(delta):
	if exploding == false:
		velocity.x = Speed * delta * Direction
		translate(velocity)
		$AnimatedSprite2.play("shoot")
	


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	
func _on_Timer_timeout():
	queue_free()


func _on_Firespit_body_entered(body):
	if "Player" in body.name:
		exploding = true
		body.hurt(damage)
		velocity = 0
		$FireTrail.emitting = false
		$FireTrail.visible = false
		$AnimatedSprite2.visible = false
		$FireExplosion.emitting = true
		$Timer.start()
