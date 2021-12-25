extends KinematicBody2D

var HP = 3
var attackStage = 0
var doAttack = true
var dead = false
var hehe111 = false
var taloned = false
onready var global_vars = get_node("/root/global_variables")

func hurt(amount):
	if HP > 0:
		HP -= amount
	if HP <= 0:
		if dead == false:
			dead()
			dead = true

func _ready():
	$Timer3.start()

func dead():
	if taloned == true:
		if get_parent().get_node("Player1").HP < global_vars.maxHP:
			get_parent().get_node("Player1").HP += 1
	$AnimatedSprite.play("death")
	if hehe111 == false:
		get_parent().amountBeaten += 1
		hehe111 = true
	$Area2D/CollisionShape2D.disabled = true
	$CollisionShape.disabled = true
	$Timer.start()

func _process(delta):
	if dead == false:
		if HP <= 0:
			dead = true
			dead()
		if attackStage == 0:
			attackStage = 2
			$AnimatedSprite.play("attack_end")
			$Area2D/CollisionShape2D.disabled = true
			
		elif attackStage == 1:
			attackStage = 3
			$AnimatedSprite.play("attack_start")
			$Area2D/CollisionShape2D.disabled = false
			
		elif attackStage == 2:
			$AnimatedSprite.play("idle")
			$Area2D/CollisionShape2D.disabled = true
			
		elif attackStage == 3:
			$AnimatedSprite.play("attack_mid")
			$Area2D/CollisionShape2D.disabled = false


func _on_Area2D_body_entered(body):
	if doAttack == true:
		if body.name == "Player1":
			body.hurt(3)
			$Timer4.start()
			doAttack = false



func _on_Timer_timeout():
	$Timer5.start()


func _on_Timer2_timeout():
	$AnimatedSprite.play("attack_end")
	attackStage = 0


func _on_Timer3_timeout():
	$Timer3.start()
	if attackStage == 2:
		attackStage = 1
		$AnimatedSprite.play("attack_start")
		$Area2D/CollisionShape2D.disabled = false
		
	elif attackStage == 3:
		attackStage = 0
		$AnimatedSprite.play("attack_end")
		$Area2D/CollisionShape2D.disabled = true
		


func _on_Timer4_timeout():
	doAttack = true


func _on_Timer5_timeout():
	$Timer.start()
	$AnimatedSprite.play("dead")
	$AnimatedSprite.modulate.a -= 0.05
	if $AnimatedSprite.modulate.a <= 0:
		queue_free()
