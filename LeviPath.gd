extends PathFollow2D
var dead = false
var HP = 24
var taloned = false
var achievement = preload("res://Placeholder Textures for Shards of the Past/achievements/squidgame_card.png")
var sonicWaveTimer = 0
var pulseTimer = 0
const SonicWave = preload("res://SonicWave.tscn")
const Breach = preload("res://Area2D_Breach_Exit.tscn")
var move = true
var doWave = true
var doPulse = true
var pulseDone = false
var waveDone = false
var Direction = 1
var offset_backup = 0
var trigger = false
var trigger2 = false
var pulseFallback = false
var waveFallback = false
var spawned = false
#var offset = 0


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func hurt(amount):
	if HP > 0:
		HP -= amount
	if HP <= 0:
		if dead == false:
			dead()
			dead = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func pulse():
	$Area2D.visible = true
	$Area2D.scale.x += 1
	$Area2D.scale.y += 1
	
func sonicWave():
	$Leviathan/AnimatedSprite.play("minibreach")
#	var Gunshot = gunshot.instance()
	var ammo1 = SonicWave.instance()
	var ammo2 = SonicWave.instance()
	ammo1.set_ammo_direction(-1)
	ammo2.set_ammo_direction(1)
	get_parent().add_child(ammo1)
	ammo1.position = $Leviathan/Position2D.global_position
	get_parent().add_child(ammo2)
	ammo2.position = $Leviathan/Position2D2.global_position
#	get_parent().add_child(Gunshot)
#	Gunshot.position = $Position2D.global_position
#	Gunshot.stream = shoot_noise
#	$AudioStreamPlayer2D.stop()
#	$AudioStreamPlayer2D.stream = shoot_noise
#	$Timer2.start()

func dead():
	$DeathTimer.start()
	dead = true
	if taloned == true:
		if get_parent().get_node("Player1").HP < global_variables.maxHP:
			get_parent().get_node("Player1").HP += 1
	$Leviathan/AnimatedSprite.play("death")
#	$Area2D/CollisionShape2D.disabled = true
	$Leviathan/CollisionShape2D.disabled = true
#	$Timer3.start()
	global_variables.maxHP = global_variables.maxHP + 2
	global_variables.leviathanBeaten = true
	get_node("/root/TheBreachLevel10/Player1").ready_HP()
	get_node("/root/TheBreachLevel10/Player1").achievement_recieved(achievement)

func _physics_process(delta):
	if dead == false:
		if get_node("../../PlayerVarHolder").PlayerAlive == true:
			if get_node("../../Player1").position.x < self.position.x:
				Direction = 1
			elif get_node("../../Player1").position.x > self.position.x:
				Direction = -1
		if Direction == 1:
			$Leviathan/AnimatedSprite.flip_h = false
		elif Direction == -1:
			$Leviathan/AnimatedSprite.flip_h = true
		if move == true:
			$"../Leviathan".set_offset(offset+1)
			$Leviathan/AnimatedSprite.play("idle")
	#		$RichTextLabel.text = str(offset)
			if offset > 0 && offset < 2:
				if pulseFallback == false:
					pulseFallback = true
					pulseDone = false
					pulseTimer = 0
					move = true
					trigger = false
			if offset > 358 && offset < 360:
				if waveFallback == false:
					waveFallback = true
					waveDone = false
					sonicWaveTimer = 0
					move = true
					trigger = false
			if pulseDone == false && move == true:
				if offset > 2 && offset < 10:
					if doPulse == true:
						pulseFallback = false
						pulseTimer = 0
						move = false
						doPulse = false
						trigger2 = true
						$PulseTimer.start()
						$Fallback2.start()
				else:
					doPulse = true
			if waveDone == false && move == true:
				if offset > 360 && offset < 380:
					if doWave == true:
						waveFallback = false
						sonicWaveTimer = 0
						doWave = false
						move = false
						trigger = true
						$SonicWaveTimer.start()
						$Fallback.start()
			else:
				doWave = true
		if HP == 24:
			get_node("/root/TheBreachLevel10/Player1/MarginContainer/HBoxContainer/Boss_HB").set_texture(get_node("/root/TheBreachLevel10/Player1").leviathan_24)
		elif HP == 23:
			get_node("/root/TheBreachLevel10/Player1/MarginContainer/HBoxContainer/Boss_HB").set_texture(get_node("/root/TheBreachLevel10/Player1").leviathan_23)
		elif HP == 22:
			get_node("/root/TheBreachLevel10/Player1/MarginContainer/HBoxContainer/Boss_HB").set_texture(get_node("/root/TheBreachLevel10/Player1").leviathan_22)
		elif HP == 21:
			get_node("/root/TheBreachLevel10/Player1/MarginContainer/HBoxContainer/Boss_HB").set_texture(get_node("/root/TheBreachLevel10/Player1").leviathan_21)
		elif HP == 20:
			get_node("/root/TheBreachLevel10/Player1/MarginContainer/HBoxContainer/Boss_HB").set_texture(get_node("/root/TheBreachLevel10/Player1").leviathan_20)
		elif HP == 19:
			get_node("/root/TheBreachLevel10/Player1/MarginContainer/HBoxContainer/Boss_HB").set_texture(get_node("/root/TheBreachLevel10/Player1").leviathan_19)
		elif HP == 18:
			get_node("/root/TheBreachLevel10/Player1/MarginContainer/HBoxContainer/Boss_HB").set_texture(get_node("/root/TheBreachLevel10/Player1").leviathan_18)
		elif HP == 17:
			get_node("/root/TheBreachLevel10/Player1/MarginContainer/HBoxContainer/Boss_HB").set_texture(get_node("/root/TheBreachLevel10/Player1").leviathan_17)
		elif HP == 16:
			get_node("/root/TheBreachLevel10/Player1/MarginContainer/HBoxContainer/Boss_HB").set_texture(get_node("/root/TheBreachLevel10/Player1").leviathan_16)
		elif HP == 15:
			get_node("/root/TheBreachLevel10/Player1/MarginContainer/HBoxContainer/Boss_HB").set_texture(get_node("/root/TheBreachLevel10/Player1").leviathan_15)
		elif HP == 14:
			get_node("/root/TheBreachLevel10/Player1/MarginContainer/HBoxContainer/Boss_HB").set_texture(get_node("/root/TheBreachLevel10/Player1").leviathan_14)
		elif HP == 13:
			get_node("/root/TheBreachLevel10/Player1/MarginContainer/HBoxContainer/Boss_HB").set_texture(get_node("/root/TheBreachLevel10/Player1").leviathan_13)
		elif HP == 12:
			get_node("/root/TheBreachLevel10/Player1/MarginContainer/HBoxContainer/Boss_HB").set_texture(get_node("/root/TheBreachLevel10/Player1").leviathan_12)
		elif HP == 11:
			get_node("/root/TheBreachLevel10/Player1/MarginContainer/HBoxContainer/Boss_HB").set_texture(get_node("/root/TheBreachLevel10/Player1").leviathan_11)
		elif HP == 10:
			get_node("/root/TheBreachLevel10/Player1/MarginContainer/HBoxContainer/Boss_HB").set_texture(get_node("/root/TheBreachLevel10/Player1").leviathan_10)
		elif HP == 9:
			get_node("/root/TheBreachLevel10/Player1/MarginContainer/HBoxContainer/Boss_HB").set_texture(get_node("/root/TheBreachLevel10/Player1").leviathan_9)
		elif HP == 8:
			get_node("/root/TheBreachLevel10/Player1/MarginContainer/HBoxContainer/Boss_HB").set_texture(get_node("/root/TheBreachLevel10/Player1").leviathan_8)
		elif HP == 7:
			get_node("/root/TheBreachLevel10/Player1/MarginContainer/HBoxContainer/Boss_HB").set_texture(get_node("/root/TheBreachLevel10/Player1").leviathan_7)
		elif HP == 6:
			get_node("/root/TheBreachLevel10/Player1/MarginContainer/HBoxContainer/Boss_HB").set_texture(get_node("/root/TheBreachLevel10/Player1").leviathan_6)
		elif HP == 5:
			get_node("/root/TheBreachLevel10/Player1/MarginContainer/HBoxContainer/Boss_HB").set_texture(get_node("/root/TheBreachLevel10/Player1").leviathan_5)
		elif HP == 4:
			get_node("/root/TheBreachLevel10/Player1/MarginContainer/HBoxContainer/Boss_HB").set_texture(get_node("/root/TheBreachLevel10/Player1").leviathan_4)
		elif HP == 3:
			get_node("/root/TheBreachLevel10/Player1/MarginContainer/HBoxContainer/Boss_HB").set_texture(get_node("/root/TheBreachLevel10/Player1").leviathan_3)
		elif HP == 2:
			get_node("/root/TheBreachLevel10/Player1/MarginContainer/HBoxContainer/Boss_HB").set_texture(get_node("/root/TheBreachLevel10/Player1").leviathan_2)
		elif HP == 1:
			get_node("/root/TheBreachLevel10/Player1/MarginContainer/HBoxContainer/Boss_HB").set_texture(get_node("/root/TheBreachLevel10/Player1").leviathan_1)
		elif HP <= 0:
			get_node("/root/TheBreachLevel10/Player1/MarginContainer/HBoxContainer/Boss_HB").set_texture(get_node("/root/TheBreachLevel10/Player1").leviathan_0)
			dead()
			dead = true


func _on_SonicWaveTimer_timeout():
	if dead == false:
		if sonicWaveTimer == 0:
			move = false
			$Leviathan/AnimatedSprite.play("minibreach")
#			var Gunshot = gunshot.instance()
			var ammo1 = SonicWave.instance()
			var ammo2 = SonicWave.instance()
			ammo1.set_ammo_direction(-1)
			ammo2.set_ammo_direction(1)
			get_parent().add_child(ammo1)
			ammo1.position = $Leviathan/Position2D.global_position
			get_parent().add_child(ammo2)
			ammo2.position = $Leviathan/Position2D2.global_position
			sonicWaveTimer = 1
			$SonicWaveTimer.start()
		elif sonicWaveTimer == 1:
			move = false
			sonicWaveTimer = 2
#			var Gunshot = gunshot.instance()
			var ammo1 = SonicWave.instance()
			var ammo2 = SonicWave.instance()
			ammo1.set_ammo_direction(-1)
			ammo2.set_ammo_direction(1)
			get_parent().add_child(ammo1)
			ammo1.position = $Leviathan/Position2D.global_position
			get_parent().add_child(ammo2)
			ammo2.position = $Leviathan/Position2D2.global_position
			$SonicWaveTimer.start()
		elif sonicWaveTimer == 2:
			move = false
			sonicWaveTimer = 3
			$Leviathan/AnimatedSprite.play("minibreach")
#			var Gunshot = gunshot.instance()
			var ammo1 = SonicWave.instance()
			var ammo2 = SonicWave.instance()
			ammo1.set_ammo_direction(-1)
			ammo2.set_ammo_direction(1)
			get_parent().add_child(ammo1)
			ammo1.position = $Leviathan/Position2D.global_position
			get_parent().add_child(ammo2)
			ammo2.position = $Leviathan/Position2D2.global_position
			$SonicWaveTimer.start()
		elif sonicWaveTimer == 3:
			move = false
			sonicWaveTimer = 4
#			var Gunshot = gunshot.instance()
			var ammo1 = SonicWave.instance()
			var ammo2 = SonicWave.instance()
			ammo1.set_ammo_direction(-1)
			ammo2.set_ammo_direction(1)
			get_parent().add_child(ammo1)
			ammo1.position = $Leviathan/Position2D.global_position
			get_parent().add_child(ammo2)
			ammo2.position = $Leviathan/Position2D2.global_position
			$SonicWaveTimer.start()
		elif sonicWaveTimer == 4:
			trigger = false
			move = true
			waveDone = true
			$Fallback.stop()


func _on_PulseTimer_timeout():
	if dead == false:
		if pulseTimer == 0:
			$Leviathan/AnimatedSprite.play("pulse")
			pulse()
			pulseTimer = 1
			$PulseTimer.start()
		elif pulseTimer == 1:
			pulse()
			pulseTimer = 2
			$PulseTimer.start()
		elif pulseTimer == 2:
			pulse()
			pulseTimer = 3
			$PulseTimer.start()
		elif pulseTimer == 3:
			$Leviathan/AnimatedSprite.play("pulse")
			pulse()
			pulseTimer = 4
			$PulseTimer.start()
		elif pulseTimer == 4:
			pulse()
			pulseTimer = 5
			$PulseTimer.start()
		elif pulseTimer == 5:
			pulse()
			pulseTimer = 6
			$PulseTimer.start()
		elif pulseTimer == 6:
			$Leviathan/AnimatedSprite.play("pulse")
			pulse()
			pulseTimer = 7
			$PulseTimer.start()
		elif pulseTimer == 7:
			pulse()
			pulseTimer = 8
			$PulseTimer.start()
		elif pulseTimer == 8:
			pulse()
			pulseTimer = 9
			$PulseTimer.start()
		elif pulseTimer == 9:
			pulse()
			pulseTimer = 10
			$PulseTimer.start()
		elif pulseTimer == 10:
			trigger = false
			$Area2D.visible = false
			$Area2D.scale.x = 1
			$Area2D.scale.y = 1
			move = true
			pulseDone = true
			$Fallback2.stop()



func _on_Fallback_timeout():
	move = false
	if sonicWaveTimer != 4 && sonicWaveTimer < 4:
		if trigger == true:
			$Fallback.start()



func _on_Fallback2_timeout():
	move = false
	if sonicWaveTimer != 4 && sonicWaveTimer < 4:
		if trigger2 == true:
			$Fallback2.start()


func _on_Area2D_body_entered(body):
	if "Player" in body.name:
		body.hurt(3)



func _on_DeathTimer_timeout():
	if spawned == false:
		spawned = true
		dead = true
		var ammo1 = Breach.instance() 
		get_parent().get_parent().add_child(ammo1)
		ammo1.position = $Position2D3.global_position
		$RichTextLabel.text = "Done!"
