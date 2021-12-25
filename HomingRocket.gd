extends KinematicBody2D

const Speed = 40
var velocity = Vector2()
var Direction = 1
var exploding = false

func _ready():
	$RayCast2D.add_exception(get_parent().get_node("Player1"))
	$RayCast2D2.add_exception(get_parent().get_node("Player1"))
	$RayCast2D3.add_exception(get_parent().get_node("Player1"))
	$RayCast2D4.add_exception(get_parent().get_node("Player1"))
	$RayCast2D5.add_exception(get_parent().get_node("Player1"))


	

func set_fireball_direction(dir):
	if dir == -1:
		$Sprite.flip_h = true
		Direction = -1
	else:
		$Sprite.flip_h = false
		Direction = 1

func _physics_process(delta):
	if exploding == false:
		if get_node("../Player1").position.x > self.position.x:
			velocity.x = Speed * delta * 1
			$Sprite.flip_h = false
			Direction = 1
		else:
			velocity.x = Speed * delta * -1
			$Sprite.flip_h = true
			Direction = -1
		if $RayCast2D3.is_colliding() == true:
			if Direction == 1:
				velocity.y = 1
		elif $RayCast2D4.is_colliding() == true:
			if Direction == -1:
				velocity.y = -1
		if $RayCast2D5.is_colliding() == true:
			velocity.y = -1
		elif $RayCast2D2.is_colliding() == true:
			if Direction == 1:
				velocity.y = 1
		elif $RayCast2D.is_colliding() == true:
			if Direction == -1:
				velocity.y = -1
		elif get_node("../Player1").position.y > self.position.y:
			velocity.y = 0.5
		elif get_node("../Player1").position.y < self.position.y:
			velocity.y = -0.5
		translate(velocity)
	


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	
func _on_Timer_timeout():
	queue_free()
	

func _on_Rocket_body_entered(body):
	if "TileMap" in body.name:
		exploding = true
		velocity = 0
		$"Trail 1".emitting = false
		$"Trail 1".visible = false
		$"Trail 2".emitting = false
		$"Trail 2".visible = false
		$Sprite.visible = false
		$Explosion.emitting = true
		$Timer.start()
	elif "Fireball" in body.name:
		exploding = true
		velocity = 0
		$"Trail 1".emitting = false
		$"Trail 1".visible = false
		$"Trail 2".emitting = false
		$"Trail 2".visible = false
		$Sprite.visible = false
		$Explosion.emitting = true
		$Timer.start()
	elif "Player1" in body.name:
		exploding = true
		body.hurt(2)
		if body.Direction == 1:
			body.velocity.x += 50
		elif body.Direction == -1:
			body.velocity.x += -50
		velocity = 0
		$"Trail 1".emitting = false
		$"Trail 1".visible = false
		$"Trail 2".emitting = false
		$"Trail 2".visible = false
		$Sprite.visible = false
		$Explosion.emitting = true
		$Timer.start()
	elif "Fiery Goliath" in body.name:
		exploding = true
		body.hurt()
		velocity = 0
		$"Trail 1".emitting = false
		$"Trail 1".visible = false
		$"Trail 2".emitting = false
		$"Trail 2".visible = false
		$Sprite.visible = false
		$Explosion.emitting = true
		$Timer.start()
	elif "Quantum Slayer" in body.name:
		exploding = true
		body.hurt()
		velocity = 0
		$"Trail 1".emitting = false
		$"Trail 1".visible = false
		$"Trail 2".emitting = false
		$"Trail 2".visible = false
		$Sprite.visible = false
		$Explosion.emitting = true
		$Timer.start()
