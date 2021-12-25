extends KinematicBody2D

const Speed = 70
const Grav = 10
const JumpPower = -235
const Floor = Vector2(0, -1)

const Fireball = preload("res://Fireball.tscn")
const Breachball = preload("res://Breachball.tscn")

const JumpSmoke = preload("res://JumpSmoke.tscn")
const PlrGhost = preload("res://PlayerGhost.tscn")
var velocity = Vector2()
var on_ground = false
var FS = 1
var Is_Attacking = false
onready var global_vars = get_node("/root/global_variables")
onready var SaveLoad = get_node("/root/SaveLoad")
var HP = 5
var file = File.new()
var isInRangeOfSign = false
var signOpened = false
var canSignBeUsed = true
var signID = "0_0"
var dialoguePart = 0
var dialogueRow = 0
var dialogueOpened = false
var dialogueRange = false
var canDialogueBeUsed = true

var dashing = false
var isOnLadder = false
var self_y = 0
var isUsingLadder = false
var canChangeLadderState = true

var dialogue_dungeon_1 = preload("res://Placeholder Textures for Shards of the Past/dialogue/dialogue_dungeon_scientist_1.png")
var dialogue_dungeon_2 = preload("res://Placeholder Textures for Shards of the Past/dialogue/dialogue_dungeon_scientist_2.png")
var dialogue_dungeon_3 = preload("res://Placeholder Textures for Shards of the Past/dialogue/dialogue_dungeon_scientist_3.png")
var dialogue_dungeon_4 = preload("res://Placeholder Textures for Shards of the Past/dialogue/dialogue_dungeon_scientist_4.png")
var dialogue_dungeon_5 = preload("res://Placeholder Textures for Shards of the Past/dialogue/dialogue_dungeon_scientist_5.png")
var dialogue_dungeon_6 = preload("res://Placeholder Textures for Shards of the Past/dialogue/dialogue_dungeon_scientist_6.png")

var dialogue_enemybase_s_1 = preload("res://Placeholder Textures for Shards of the Past/dialogue/dialogue_enemybase_scientist_1.png")
var dialogue_enemybase_s_2 = preload("res://Placeholder Textures for Shards of the Past/dialogue/dialogue_enemybase_scientist_2.png")
var dialogue_enemybase_s_3 = preload("res://Placeholder Textures for Shards of the Past/dialogue/dialogue_enemybase_scientist_3.png")
var dialogue_enemybase_s_4 = preload("res://Placeholder Textures for Shards of the Past/dialogue/dialogue_enemybase_scientist_4.png")
var dialogue_enemybase_s_5 = preload("res://Placeholder Textures for Shards of the Past/dialogue/dialogue_enemybase_scientist_5.png")

var dialogue_enemybase_g_1 = preload("res://Placeholder Textures for Shards of the Past/dialogue/dialogue_enemybase_general.png")

var dialogue_5 = preload("res://Placeholder Textures for Shards of the Past/dialogue/dialogue_unknown-transmission_1.png")
var dialogue_6 = preload("res://Placeholder Textures for Shards of the Past/dialogue/dialogue_old-scientist_5.png")
var dialogue_7 = preload("res://Placeholder Textures for Shards of the Past/dialogue/dialogue_army-officer_1.png")
var dialogue_8 = preload("res://Placeholder Textures for Shards of the Past/dialogue/dialogue_army-officer_1.png")
var dialogue_9 = preload("res://Placeholder Textures for Shards of the Past/dialogue/dialogue_army-officer_1.png")
var dialogue_10 = preload("res://Placeholder Textures for Shards of the Past/dialogue/dialogue_army-officer_1.png")

var dialogue_breach_1 = preload("res://Placeholder Textures for Shards of the Past/dialogue/dialogue_breach_1.png")
var dialogue_breach_2 = preload("res://Placeholder Textures for Shards of the Past/dialogue/dialogue_breach_2.png")
var dialogue_breach_3 = preload("res://Placeholder Textures for Shards of the Past/dialogue/dialogue_breach_3.png")
var dialogue_breach_4 = preload("res://Placeholder Textures for Shards of the Past/dialogue/dialogue_breach_4.png")
var dialogue_breach_5 = preload("res://Placeholder Textures for Shards of the Past/dialogue/dialogue_breach_5.png")
var dialogue_breach_6 = preload("res://Placeholder Textures for Shards of the Past/dialogue/dialogue_breach_6.png")
var dialogue_breach_7 = preload("res://Placeholder Textures for Shards of the Past/dialogue/dialogue_breach_7.png")
var dialogue_breach_8 = preload("res://Placeholder Textures for Shards of the Past/dialogue/dialogue_breach_8.png")
var dialogue_breach_9 = preload("res://Placeholder Textures for Shards of the Past/dialogue/dialogue_breach_9.png")
var dialogue_breach_10 = preload("res://Placeholder Textures for Shards of the Past/dialogue/dialogue_breach_10.png")
var dialogue_breach_11 = preload("res://Placeholder Textures for Shards of the Past/dialogue/dialogue_breach_11.png")
var dialogue_breach_12 = preload("res://Placeholder Textures for Shards of the Past/dialogue/dialogue_breach_12.png")
var dialogue_breach_13 = preload("res://Placeholder Textures for Shards of the Past/dialogue/dialogue_breach_13.png")
var dialogue_breach_14 = preload("res://Placeholder Textures for Shards of the Past/dialogue/dialogue_breach_14.png")
var dialogue_breach_15 = preload("res://Placeholder Textures for Shards of the Past/dialogue/dialogue_breach_15.png")
var dialogue_breach_16 = preload("res://Placeholder Textures for Shards of the Past/dialogue/dialogue_breach_16.png")
var dialogue_breach_17 = preload("res://Placeholder Textures for Shards of the Past/dialogue/dialogue_breach_17.png")
var dialogue_breach_18 = preload("res://Placeholder Textures for Shards of the Past/dialogue/dialogue_breach_18.png")
var dialogue_breach_19 = preload("res://Placeholder Textures for Shards of the Past/dialogue/dialogue_breach_19.png")
var dialogue_breach_20 = preload("res://Placeholder Textures for Shards of the Past/dialogue/dialogue_breach_20.png")


const sign1_1 = preload("res://Placeholder Textures for Shards of the Past/sign/genetics_lab.png")
const sign1_2 = preload("res://Placeholder Textures for Shards of the Past/sign/lab_arena_attention.png")
const sign2_1 = preload("res://Placeholder Textures for Shards of the Past/sign/lab_attention.png")
const sign5_1 = preload("res://Placeholder Textures for Shards of the Past/sign/desert_attention.png")
const sign5_2 = preload("res://Placeholder Textures for Shards of the Past/sign/danger_sign.png")
const sign5_3 = preload("res://Placeholder Textures for Shards of the Past/sign/desert_attention_2.png")
const sign6_1 = preload("res://Placeholder Textures for Shards of the Past/sign/cave_danger.png")
const sign8_1 = preload("res://Placeholder Textures for Shards of the Past/sign/base_proximity_danger.png")
const sign_error = preload("res://Placeholder Textures for Shards of the Past/sign/lorem_ipsum.png")

var health_flash_texture = preload("res://Placeholder Textures for Shards of the Past/health/health_flash.png")
var health_no_texture = preload("res://Placeholder Textures for Shards of the Past/health/health_no.png")
var health_texture = preload("res://Placeholder Textures for Shards of the Past/health/health.png")
var health_bonus_flash_texture = preload("res://Placeholder Textures for Shards of the Past/health/health_bonus_flash.png")
var health_bonus_no_texture = preload("res://Placeholder Textures for Shards of the Past/health/health_bonus_no.png")
var health_bonus_texture = preload("res://Placeholder Textures for Shards of the Past/health/health_bonus.png")
var health_bonus_flash_ubercharge = preload("res://Placeholder Textures for Shards of the Past/health/health_bonus_ubercharge_flash.png")
var health_bonus_no_ubercharge = preload("res://Placeholder Textures for Shards of the Past/health/health_bonus_ubercharge_no.png")
var health_bonus_ubercharge = preload("res://Placeholder Textures for Shards of the Past/health/health_bonus_ubercharge.png")

var goliath_full = preload("res://Placeholder Textures for Shards of the Past/fierygoliath_healthbar/fierygoliath_healthbar_full.png")
var goliath_80 = preload("res://Placeholder Textures for Shards of the Past/fierygoliath_healthbar/fierygoliath_healthbar_80.png")
var goliath_60 = preload("res://Placeholder Textures for Shards of the Past/fierygoliath_healthbar/fierygoliath_healthbar_60.png")
var goliath_40 = preload("res://Placeholder Textures for Shards of the Past/fierygoliath_healthbar/fierygoliath_healthbar_40.png")
var goliath_20 = preload("res://Placeholder Textures for Shards of the Past/fierygoliath_healthbar/fierygoliath_healthbar_20.png")
var goliath_dead = preload("res://Placeholder Textures for Shards of the Past/fierygoliath_healthbar/fierygoliath_healthbar_0.png")

var abil_pb = preload("res://Placeholder Textures for Shards of the Past/gui/abilitydisplay_plasmaball.png")
var abil_punch = preload("res://Placeholder Textures for Shards of the Past/gui/abilitydisplay_punch.png")
var abil_talon = preload("res://Placeholder Textures for Shards of the Past/gui/abilitydisplay_fleshytalon.png")
var abil_dash = preload("res://Placeholder Textures for Shards of the Past/gui/abilitydisplay_dash.png")
var abil_djump = preload("res://Placeholder Textures for Shards of the Past/gui/abilitydisplay_doublejump.png")
var abil_bb = preload("res://Placeholder Textures for Shards of the Past/gui/abilitydisplay_breachball.png")

var slayer_full = preload("res://Placeholder Textures for Shards of the Past/quantumslayer_healthbar/quantumslayer_healthbar_full.png")
var slayer_5_6 = preload("res://Placeholder Textures for Shards of the Past/quantumslayer_healthbar/quantumslayer_healthbar_5.png")
var slayer_4_6 = preload("res://Placeholder Textures for Shards of the Past/quantumslayer_healthbar/quantumslayer_healthbar_4.png")
var slayer_3_6 = preload("res://Placeholder Textures for Shards of the Past/quantumslayer_healthbar/quantumslayer_healthbar_3.png")
var slayer_2_6 = preload("res://Placeholder Textures for Shards of the Past/quantumslayer_healthbar/quantumslayer_healthbar_2.png")
var slayer_1_6 = preload("res://Placeholder Textures for Shards of the Past/quantumslayer_healthbar/quantumslayer_healthbar_1.png")
var slayer_dead = preload("res://Placeholder Textures for Shards of the Past/quantumslayer_healthbar/quantumslayer_healthbar_dead.png")

var tumbleblade_full = preload("res://Placeholder Textures for Shards of the Past/tumbleblade/tumbleblade_healthbar_full.png")
var tumbleblade_5_6 = preload("res://Placeholder Textures for Shards of the Past/tumbleblade/tumbleblade_healthbar_5.png")
var tumbleblade_4_6 = preload("res://Placeholder Textures for Shards of the Past/tumbleblade/tumbleblade_healthbar_4.png")
var tumbleblade_3_6 = preload("res://Placeholder Textures for Shards of the Past/tumbleblade/tumbleblade_healthbar_3.png")
var tumbleblade_2_6 = preload("res://Placeholder Textures for Shards of the Past/tumbleblade/tumbleblade_healthbar_2.png")
var tumbleblade_1_6 = preload("res://Placeholder Textures for Shards of the Past/tumbleblade/tumbleblade_healthbar_1.png")
var tumbleblade_0_6 = preload("res://Placeholder Textures for Shards of the Past/tumbleblade/tumbleblade_healthbar_0.png")

var blightpack_full = preload("res://Placeholder Textures for Shards of the Past/blightpack/blightpack_healthbar_full.png")
var blightpack_3_4 = preload("res://Placeholder Textures for Shards of the Past/blightpack/blightpack_healthbar_75.png")
var blightpack_2_4 = preload("res://Placeholder Textures for Shards of the Past/blightpack/blightpack_healthbar_50.png")
var blightpack_1_4 = preload("res://Placeholder Textures for Shards of the Past/blightpack/blightpack_healthbar_25.png")
var blightpack_0_4 = preload("res://Placeholder Textures for Shards of the Past/blightpack/blightpack_healthbar_0.png")

var blightmother_full = preload("res://Placeholder Textures for Shards of the Past/blightmother/blightmother_healthbar_full.png")
var blightmother_7_8 = preload("res://Placeholder Textures for Shards of the Past/blightmother/blightmother_healthbar_87,5.png")
var blightmother_6_8 = preload("res://Placeholder Textures for Shards of the Past/blightmother/blightmother_healthbar_75.png")
var blightmother_5_8 = preload("res://Placeholder Textures for Shards of the Past/blightmother/blightmother_healthbar_62,5.png")
var blightmother_4_8 = preload("res://Placeholder Textures for Shards of the Past/blightmother/blightmother_healthbar_50.png")
var blightmother_3_8 = preload("res://Placeholder Textures for Shards of the Past/blightmother/blightmother_healthbar_37,5.png")
var blightmother_2_8 = preload("res://Placeholder Textures for Shards of the Past/blightmother/blightmother_healthbar_25.png")
var blightmother_1_8 = preload("res://Placeholder Textures for Shards of the Past/blightmother/blightmother_healthbar_12,5.png")
var blightmother_0_8 = preload("res://Placeholder Textures for Shards of the Past/blightmother/blightmother_healthbar_0.png")

var leviathan_24 = preload("res://Placeholder Textures for Shards of the Past/leviathan/leviathan_healthbar_24.png")
var leviathan_23 = preload("res://Placeholder Textures for Shards of the Past/leviathan/leviathan_healthbar_23.png")
var leviathan_22 = preload("res://Placeholder Textures for Shards of the Past/leviathan/leviathan_healthbar_22.png")
var leviathan_21 = preload("res://Placeholder Textures for Shards of the Past/leviathan/leviathan_healthbar_21.png")
var leviathan_20 = preload("res://Placeholder Textures for Shards of the Past/leviathan/leviathan_healthbar_20.png")
var leviathan_19 = preload("res://Placeholder Textures for Shards of the Past/leviathan/leviathan_healthbar_19.png")
var leviathan_18 = preload("res://Placeholder Textures for Shards of the Past/leviathan/leviathan_healthbar_18.png")
var leviathan_17 = preload("res://Placeholder Textures for Shards of the Past/leviathan/leviathan_healthbar_17.png")
var leviathan_16 = preload("res://Placeholder Textures for Shards of the Past/leviathan/leviathan_healthbar_16.png")
var leviathan_15 = preload("res://Placeholder Textures for Shards of the Past/leviathan/leviathan_healthbar_15.png")
var leviathan_14 = preload("res://Placeholder Textures for Shards of the Past/leviathan/leviathan_healthbar_14.png")
var leviathan_13 = preload("res://Placeholder Textures for Shards of the Past/leviathan/leviathan_healthbar_13.png")
var leviathan_12 = preload("res://Placeholder Textures for Shards of the Past/leviathan/leviathan_healthbar_12.png")
var leviathan_11 = preload("res://Placeholder Textures for Shards of the Past/leviathan/leviathan_healthbar_11.png")
var leviathan_10 = preload("res://Placeholder Textures for Shards of the Past/leviathan/leviathan_healthbar_10.png")
var leviathan_9 = preload("res://Placeholder Textures for Shards of the Past/leviathan/leviathan_healthbar_9.png")
var leviathan_8 = preload("res://Placeholder Textures for Shards of the Past/leviathan/leviathan_healthbar_8.png")
var leviathan_7 = preload("res://Placeholder Textures for Shards of the Past/leviathan/leviathan_healthbar_7.png")
var leviathan_6 = preload("res://Placeholder Textures for Shards of the Past/leviathan/leviathan_healthbar_6.png")
var leviathan_5 = preload("res://Placeholder Textures for Shards of the Past/leviathan/leviathan_healthbar_5.png")
var leviathan_4 = preload("res://Placeholder Textures for Shards of the Past/leviathan/leviathan_healthbar_4.png")
var leviathan_3 = preload("res://Placeholder Textures for Shards of the Past/leviathan/leviathan_healthbar_3.png")
var leviathan_2 = preload("res://Placeholder Textures for Shards of the Past/leviathan/leviathan_healthbar_2.png")
var leviathan_1 = preload("res://Placeholder Textures for Shards of the Past/leviathan/leviathan_healthbar_1.png")
var leviathan_0 = preload("res://Placeholder Textures for Shards of the Past/leviathan/leviathan_healthbar_0.png")

var lab_ambience = preload("res://sfx/lab_ambient.ogg")
var milcamp_ambience = preload("res://sfx/milcamp_ambient.ogg")
var desert_ambience = preload("res://sfx/desert_ambient.ogg")
var dungeon_ambience = preload("res://sfx/dungeon_ambient.ogg")
var cave_ambience = preload("res://sfx/cave_ambient.ogg")
var dreamscape_ambience = preload("res://sfx/dreamscape_ambient.ogg")
var enemybase_ambience = preload("res://sfx/enemybase_ambient.ogg")
var warehouse_ambience = preload("res://sfx/warehouse_ambient.ogg")

var active_ability = 1
var active_movement_ability = 1
var projectile = false
var Direction = 1
var pausemenushown = -1
var dashable = false
var jump_count = 0
var shadow_spawnable = true
var can_change_jc = true
var dashableStateChangable = true
var timer_started = false
var can_dash = true
var escapeDialogueActivated = false
var dashDialogueActivated = false
var lifesteal_unlocked = false
var dash_unlocked = false
var TransitionFinished = false
var Transition_in_out = 0

var arbitrary_value = 0
var Unlock1 = preload("res://Placeholder Textures for Shards of the Past/gui/dash_unlock.png")
var Unlock2 = preload("res://Placeholder Textures for Shards of the Past/gui/talon_unlock.png")
var Unlock3 = preload("res://Placeholder Textures for Shards of the Past/gui/breachball_unlock.png")
var in_or_out = 1
var animate = true

func achievement_recieved(texture):
	$MarginContainer/HBoxContainer/Achievement.texture = texture
	$MarginContainer/HBoxContainer/Achievement.show()
	$Timer13.start()
	
func _ready():
	SaveLoad._load()
	ready_HP()
	HP = global_vars.maxHP
	$RichTextLabel.text = str(global_vars.maxHP)
	Transition_in()
	


func Transition_in():
	Transition_in_out = 1
	$Timer15.start()
	$Transition.modulate.a -= 0.1
	if $Transition.modulate.a <= 0:
		pass


func Transition_out():
	Transition_in_out = 2
	$Timer15.start()
	$Transition.modulate.a += 0.1
	if $Transition.modulate.a >= 100:
		pass


func _on_Timer15_timeout():
	if Transition_in_out == 1:
		if $Transition.modulate.a <= 0:
			pass
		else:
			$Transition.modulate.a -= 0.03
			$Timer15.start()
	elif Transition_in_out == 2:
		if $Transition.modulate.a >= 1:
			TransitionFinished = true
		else:
			$Transition.modulate.a += 0.03
			$Timer15.start()
	

func ready_HP():
	if global_vars.maxHP == 5:
		get_node("MarginContainer/HBoxContainer/Heart_5").show()
	elif global_vars.maxHP == 6:
		get_node("MarginContainer/HBoxContainer/Heart_5").show()
		get_node("MarginContainer/HBoxContainer/Heart_6").show()
	elif global_vars.maxHP == 7:
		get_node("MarginContainer/HBoxContainer/Heart_5").show()
		get_node("MarginContainer/HBoxContainer/Heart_6").show()
		get_node("MarginContainer/HBoxContainer/Heart_7").show()
	elif global_vars.maxHP == 8:
		get_node("MarginContainer/HBoxContainer/Heart_5").show()
		get_node("MarginContainer/HBoxContainer/Heart_6").show()
		get_node("MarginContainer/HBoxContainer/Heart_7").show()
		get_node("MarginContainer/HBoxContainer/Heart_8").show()
	elif global_vars.maxHP == 9:
		get_node("MarginContainer/HBoxContainer/Heart_5").show()
		get_node("MarginContainer/HBoxContainer/Heart_6").show()
		get_node("MarginContainer/HBoxContainer/Heart_7").show()
		get_node("MarginContainer/HBoxContainer/Heart_8").show()
		get_node("MarginContainer/HBoxContainer/Heart_9").show()
	elif global_vars.maxHP == 10:
		get_node("MarginContainer/HBoxContainer/Heart_5").show()
		get_node("MarginContainer/HBoxContainer/Heart_6").show()
		get_node("MarginContainer/HBoxContainer/Heart_7").show()
		get_node("MarginContainer/HBoxContainer/Heart_8").show()
		get_node("MarginContainer/HBoxContainer/Heart_9").show()
		get_node("MarginContainer/HBoxContainer/Heart_10").show()
	elif global_vars.maxHP == 11:
		get_node("MarginContainer/HBoxContainer/Heart_5").show()
		get_node("MarginContainer/HBoxContainer/Heart_6").show()
		get_node("MarginContainer/HBoxContainer/Heart_7").show()
		get_node("MarginContainer/HBoxContainer/Heart_8").show()
		get_node("MarginContainer/HBoxContainer/Heart_9").show()
		get_node("MarginContainer/HBoxContainer/Heart_10").show()
		get_node("MarginContainer/HBoxContainer/Heart_11").show()
	
func dead():
	get_parent().get_node("PlayerVarHolder").PlayerAlive = false
	self.position.x = 37
	self.position.y = 148
	get_node("MarginContainer/HBoxContainer/Heart_11").set_texture(health_bonus_flash_texture)
	get_node("MarginContainer/HBoxContainer/Heart_10").set_texture(health_bonus_flash_texture)
	get_node("MarginContainer/HBoxContainer/Heart_9").set_texture(health_bonus_flash_texture)
	get_node("MarginContainer/HBoxContainer/Heart_8").set_texture(health_bonus_flash_texture)
	get_node("MarginContainer/HBoxContainer/Heart_7").set_texture(health_bonus_flash_texture)
	get_node("MarginContainer/HBoxContainer/Heart_6").set_texture(health_bonus_flash_texture)
	get_node("MarginContainer/HBoxContainer/Heart_5").set_texture(health_flash_texture)
	get_node("MarginContainer/HBoxContainer/Heart_4").set_texture(health_flash_texture)
	get_node("MarginContainer/HBoxContainer/Heart_3").set_texture(health_flash_texture)
	get_node("MarginContainer/HBoxContainer/Heart_2").set_texture(health_flash_texture)
	get_node("MarginContainer/HBoxContainer/Heart_1").set_texture(health_flash_texture)
	$Timer3.start()
	HP = global_vars.maxHP
	
func full_heal():
	HP = global_vars.maxHP
	get_node("MarginContainer/HBoxContainer/Heart_10").set_texture(health_bonus_flash_texture)
	get_node("MarginContainer/HBoxContainer/Heart_10").set_texture(health_bonus_flash_texture)
	get_node("MarginContainer/HBoxContainer/Heart_9").set_texture(health_bonus_flash_texture)
	get_node("MarginContainer/HBoxContainer/Heart_8").set_texture(health_bonus_flash_texture)
	get_node("MarginContainer/HBoxContainer/Heart_7").set_texture(health_bonus_flash_texture)
	get_node("MarginContainer/HBoxContainer/Heart_6").set_texture(health_bonus_flash_texture)
	get_node("MarginContainer/HBoxContainer/Heart_5").set_texture(health_flash_texture)
	get_node("MarginContainer/HBoxContainer/Heart_4").set_texture(health_flash_texture)
	get_node("MarginContainer/HBoxContainer/Heart_3").set_texture(health_flash_texture)
	get_node("MarginContainer/HBoxContainer/Heart_2").set_texture(health_flash_texture)
	get_node("MarginContainer/HBoxContainer/Heart_1").set_texture(health_flash_texture)
	$Timer3.start()
	
func hurt(amount):
	$Timer18.start()
	$AnimatedSprite.modulate.r = 100
	$AnimatedSprite.modulate.g = 100
	$AnimatedSprite.modulate.b = 100
	HP = HP - amount
	if HP == 13:
		get_node("MarginContainer/HBoxContainer/Heart_11").set_texture(health_bonus_flash_ubercharge)
		$Timer2.start()
	elif HP == 12:
		get_node("MarginContainer/HBoxContainer/Heart_11").set_texture(health_bonus_flash_ubercharge)
		$Timer2.start()
	elif HP == 11:
		get_node("MarginContainer/HBoxContainer/Heart_11").set_texture(health_bonus_flash_ubercharge)
		$Timer2.start()
	elif HP == 10:
		get_node("MarginContainer/HBoxContainer/Heart_10").set_texture(health_bonus_flash_texture)
		$Timer2.start()
	elif HP == 9:
		get_node("MarginContainer/HBoxContainer/Heart_10").set_texture(health_bonus_flash_texture)
		$Timer2.start()
	elif HP == 8:
		get_node("MarginContainer/HBoxContainer/Heart_9").set_texture(health_bonus_flash_texture)
		$Timer2.start()
	elif HP == 7:
		get_node("MarginContainer/HBoxContainer/Heart_8").set_texture(health_bonus_flash_texture)
		$Timer2.start()
	elif HP == 6:
		get_node("MarginContainer/HBoxContainer/Heart_7").set_texture(health_bonus_flash_texture)
		$Timer2.start()
	elif HP == 5:
		get_node("MarginContainer/HBoxContainer/Heart_6").set_texture(health_bonus_flash_texture)
		$Timer2.start()
	elif HP == 4:
		get_node("MarginContainer/HBoxContainer/Heart_5").set_texture(health_flash_texture)
		$Timer2.start()
	elif HP == 3:
		get_node("MarginContainer/HBoxContainer/Heart_4").set_texture(health_flash_texture)
		$Timer2.start()
	elif HP == 2:
		get_node("MarginContainer/HBoxContainer/Heart_3").set_texture(health_flash_texture)
		$Timer2.start()
	elif HP == 1:
		get_node("MarginContainer/HBoxContainer/Heart_2").set_texture(health_flash_texture)
		$Timer2.start()
	elif HP == 0:
		get_node("MarginContainer/HBoxContainer/Heart_1").set_texture(health_flash_texture)
		$Timer2.start()

func landmine_physics_override():
	$Timer5.start()
	if velocity.x <= 0:
		velocity.x = 300
	elif velocity.x >= 0:
		velocity.x = -300 
	velocity.y = -400
	velocity.x = lerp(velocity.x, 0, 0.1)
	
func landslide_override():
	velocity.y = 1000

func _save():
	if get_parent().name == "TutorialLevel":
		SaveLoad._save(0, HP)
	elif get_parent().name == "TheLabLevel1":
		SaveLoad._save(1, HP)
	elif get_parent().name == "MilCampLevel2":
		SaveLoad._save(2, HP)
	elif get_parent().name == "DesertLevel5":
		SaveLoad._save(3, HP)
	elif get_parent().name == "DungeonLevel6":
		SaveLoad._save(4, HP)
	elif get_parent().name == "TheCaveLevel3":
		SaveLoad._save(5, HP)
	elif get_parent().name == "DreamscapeLevel7":
		SaveLoad._save(6, HP)

#func _process(delta: float) -> void:
#	if !$Music.is_playing():
#		if get_parent().name == "TutorialLevel":
#			$Music.stream = lab_ambience
#		elif get_parent().name == "TheLabLevel1":
#			$Music.stream = lab_ambience
#		elif get_parent().name == "MilCampLevel2":
#			$Music.stream = milcamp_ambience
#		elif get_parent().name == "DesertLevel5":
#			$Music.stream = desert_ambience
#		elif get_parent().name == "DungeonLevel6":
#			$Music.stream = dungeon_ambience
#		elif get_parent().name == "TheCaveLevel3":
#			$Music.stream = cave_ambience
#		elif get_parent().name == "DreamscapeLevel7":
#			$Music.stream = dreamscape_ambience
#		elif get_parent().name == "EnemyBaseLevel8":
#			$Music.stream = enemybase_ambience
#		elif get_parent().name == "WarehouseLevel9":
#			$Music.stream = warehouse_ambience
#		$Music.play()

func _physics_process(delta):
	if global_vars.tumblebladeBeaten == true:
		dash_unlocked = true
	if global_vars.blightmotherBeaten == true:
		lifesteal_unlocked = true
	if HP == 1:
		get_node("MarginContainer/HBoxContainer/Heart_1").set_texture(health_texture)
	elif HP == 2:
		get_node("MarginContainer/HBoxContainer/Heart_1").set_texture(health_texture)
		get_node("MarginContainer/HBoxContainer/Heart_2").set_texture(health_texture)
	elif HP == 3:
		get_node("MarginContainer/HBoxContainer/Heart_1").set_texture(health_texture)
		get_node("MarginContainer/HBoxContainer/Heart_2").set_texture(health_texture)
		get_node("MarginContainer/HBoxContainer/Heart_3").set_texture(health_texture)
	elif HP == 4:
		get_node("MarginContainer/HBoxContainer/Heart_1").set_texture(health_texture)
		get_node("MarginContainer/HBoxContainer/Heart_2").set_texture(health_texture)
		get_node("MarginContainer/HBoxContainer/Heart_3").set_texture(health_texture)
		get_node("MarginContainer/HBoxContainer/Heart_4").set_texture(health_texture)
	elif HP == 5:
		get_node("MarginContainer/HBoxContainer/Heart_1").set_texture(health_texture)
		get_node("MarginContainer/HBoxContainer/Heart_2").set_texture(health_texture)
		get_node("MarginContainer/HBoxContainer/Heart_3").set_texture(health_texture)
		get_node("MarginContainer/HBoxContainer/Heart_4").set_texture(health_texture)
		get_node("MarginContainer/HBoxContainer/Heart_5").set_texture(health_texture)
	elif HP == 6:
		get_node("MarginContainer/HBoxContainer/Heart_1").set_texture(health_texture)
		get_node("MarginContainer/HBoxContainer/Heart_2").set_texture(health_texture)
		get_node("MarginContainer/HBoxContainer/Heart_3").set_texture(health_texture)
		get_node("MarginContainer/HBoxContainer/Heart_4").set_texture(health_texture)
		get_node("MarginContainer/HBoxContainer/Heart_5").set_texture(health_texture)
		get_node("MarginContainer/HBoxContainer/Heart_6").set_texture(health_bonus_texture)
	elif HP == 7:
		get_node("MarginContainer/HBoxContainer/Heart_1").set_texture(health_texture)
		get_node("MarginContainer/HBoxContainer/Heart_2").set_texture(health_texture)
		get_node("MarginContainer/HBoxContainer/Heart_3").set_texture(health_texture)
		get_node("MarginContainer/HBoxContainer/Heart_4").set_texture(health_texture)
		get_node("MarginContainer/HBoxContainer/Heart_5").set_texture(health_texture)
		get_node("MarginContainer/HBoxContainer/Heart_6").set_texture(health_bonus_texture)
		get_node("MarginContainer/HBoxContainer/Heart_7").set_texture(health_bonus_texture)
	elif HP == 8:
		get_node("MarginContainer/HBoxContainer/Heart_1").set_texture(health_texture)
		get_node("MarginContainer/HBoxContainer/Heart_2").set_texture(health_texture)
		get_node("MarginContainer/HBoxContainer/Heart_3").set_texture(health_texture)
		get_node("MarginContainer/HBoxContainer/Heart_4").set_texture(health_texture)
		get_node("MarginContainer/HBoxContainer/Heart_5").set_texture(health_texture)
		get_node("MarginContainer/HBoxContainer/Heart_6").set_texture(health_bonus_texture)
		get_node("MarginContainer/HBoxContainer/Heart_7").set_texture(health_bonus_texture)
		get_node("MarginContainer/HBoxContainer/Heart_8").set_texture(health_bonus_texture)
	elif HP == 9:
		get_node("MarginContainer/HBoxContainer/Heart_1").set_texture(health_texture)
		get_node("MarginContainer/HBoxContainer/Heart_2").set_texture(health_texture)
		get_node("MarginContainer/HBoxContainer/Heart_3").set_texture(health_texture)
		get_node("MarginContainer/HBoxContainer/Heart_4").set_texture(health_texture)
		get_node("MarginContainer/HBoxContainer/Heart_5").set_texture(health_texture)
		get_node("MarginContainer/HBoxContainer/Heart_6").set_texture(health_bonus_texture)
		get_node("MarginContainer/HBoxContainer/Heart_7").set_texture(health_bonus_texture)
		get_node("MarginContainer/HBoxContainer/Heart_8").set_texture(health_bonus_texture)
		get_node("MarginContainer/HBoxContainer/Heart_9").set_texture(health_bonus_texture)
	elif HP == 10:
		get_node("MarginContainer/HBoxContainer/Heart_1").set_texture(health_texture)
		get_node("MarginContainer/HBoxContainer/Heart_2").set_texture(health_texture)
		get_node("MarginContainer/HBoxContainer/Heart_3").set_texture(health_texture)
		get_node("MarginContainer/HBoxContainer/Heart_4").set_texture(health_texture)
		get_node("MarginContainer/HBoxContainer/Heart_5").set_texture(health_texture)
		get_node("MarginContainer/HBoxContainer/Heart_6").set_texture(health_bonus_texture)
		get_node("MarginContainer/HBoxContainer/Heart_7").set_texture(health_bonus_texture)
		get_node("MarginContainer/HBoxContainer/Heart_8").set_texture(health_bonus_texture)
		get_node("MarginContainer/HBoxContainer/Heart_9").set_texture(health_bonus_texture)
		get_node("MarginContainer/HBoxContainer/Heart_10").set_texture(health_bonus_texture)
	elif HP == 11:
		get_node("MarginContainer/HBoxContainer/Heart_1").set_texture(health_texture)
		get_node("MarginContainer/HBoxContainer/Heart_2").set_texture(health_texture)
		get_node("MarginContainer/HBoxContainer/Heart_3").set_texture(health_texture)
		get_node("MarginContainer/HBoxContainer/Heart_4").set_texture(health_texture)
		get_node("MarginContainer/HBoxContainer/Heart_5").set_texture(health_texture)
		get_node("MarginContainer/HBoxContainer/Heart_6").set_texture(health_bonus_texture)
		get_node("MarginContainer/HBoxContainer/Heart_7").set_texture(health_bonus_texture)
		get_node("MarginContainer/HBoxContainer/Heart_8").set_texture(health_bonus_texture)
		get_node("MarginContainer/HBoxContainer/Heart_9").set_texture(health_bonus_texture)
		get_node("MarginContainer/HBoxContainer/Heart_10").set_texture(health_bonus_texture)
		get_node("MarginContainer/HBoxContainer/Heart_11").set_texture(health_bonus_ubercharge)
	elif HP == 12:
		get_node("MarginContainer/HBoxContainer/Heart_1").set_texture(health_texture)
		get_node("MarginContainer/HBoxContainer/Heart_2").set_texture(health_texture)
		get_node("MarginContainer/HBoxContainer/Heart_3").set_texture(health_texture)
		get_node("MarginContainer/HBoxContainer/Heart_4").set_texture(health_texture)
		get_node("MarginContainer/HBoxContainer/Heart_5").set_texture(health_texture)
		get_node("MarginContainer/HBoxContainer/Heart_6").set_texture(health_bonus_texture)
		get_node("MarginContainer/HBoxContainer/Heart_7").set_texture(health_bonus_texture)
		get_node("MarginContainer/HBoxContainer/Heart_8").set_texture(health_bonus_texture)
		get_node("MarginContainer/HBoxContainer/Heart_9").set_texture(health_bonus_texture)
		get_node("MarginContainer/HBoxContainer/Heart_10").set_texture(health_bonus_texture)
		get_node("MarginContainer/HBoxContainer/Heart_11").set_texture(health_bonus_ubercharge)
		get_node("MarginContainer/HBoxContainer/Heart_12").set_texture(health_bonus_ubercharge)
	elif HP == 13:
		get_node("MarginContainer/HBoxContainer/Heart_1").set_texture(health_texture)
		get_node("MarginContainer/HBoxContainer/Heart_2").set_texture(health_texture)
		get_node("MarginContainer/HBoxContainer/Heart_3").set_texture(health_texture)
		get_node("MarginContainer/HBoxContainer/Heart_4").set_texture(health_texture)
		get_node("MarginContainer/HBoxContainer/Heart_5").set_texture(health_texture)
		get_node("MarginContainer/HBoxContainer/Heart_6").set_texture(health_bonus_texture)
		get_node("MarginContainer/HBoxContainer/Heart_7").set_texture(health_bonus_texture)
		get_node("MarginContainer/HBoxContainer/Heart_8").set_texture(health_bonus_texture)
		get_node("MarginContainer/HBoxContainer/Heart_9").set_texture(health_bonus_texture)
		get_node("MarginContainer/HBoxContainer/Heart_10").set_texture(health_bonus_texture)
		get_node("MarginContainer/HBoxContainer/Heart_11").set_texture(health_bonus_ubercharge)
		get_node("MarginContainer/HBoxContainer/Heart_12").set_texture(health_bonus_ubercharge)
		get_node("MarginContainer/HBoxContainer/Heart_13").set_texture(health_bonus_ubercharge)
	if escapeDialogueActivated == false:
		if dialoguePart == 12:
			$"MarginContainer/HBoxContainer/Dialogue".texture = dialogue_enemybase_g_1
			dialoguePart = -1
			$"MarginContainer/HBoxContainer/Dialogue".show()
			canDialogueBeUsed = false
			$Timer6.start()
			escapeDialogueActivated = true
	if global_vars.tv_overlay == 0:
		$Shader/Control.hide()
	else:
		$Shader/Control.show()
	if HP > 0:
		if isInRangeOfSign == false:
			$"MarginContainer/HBoxContainer/Sign".hide()
			signOpened = false
		if signOpened == false:
			$"MarginContainer/HBoxContainer/Sign".hide()
			
		if isUsingLadder == true:
			if Input.is_action_pressed("ui_climb_up"):
				velocity.y = -50
				$AnimatedSprite.play("climb")
			elif Input.is_action_pressed("ui_climb_down"):
				velocity.y = 50
				$AnimatedSprite.play("climb")
			else:
				velocity.y = 0
				$AnimatedSprite.play("climb_idle")
		elif active_movement_ability == 2:
			if Input.is_action_pressed("ui_climb_down"):
				if can_dash == true:
					if Is_Attacking == false:
						if dashable == true:
							if timer_started == false:
								$Timer11.start()
								timer_started = true
							dashing = true
							$AnimatedSprite.play("fall")
							velocity.y = 0
							if Direction == 1:
								velocity.x = 200
							elif Direction == -1:
								velocity.x = -200
							if shadow_spawnable == true:
								var plrGhost = PlrGhost.instance()
								shadow_spawnable = false
								$Timer10.start()
								get_parent().add_child(plrGhost)
								plrGhost.position = $Position2D3.global_position
						else:
							dashing = false
				elif can_dash == false:
					dashing = false
			if Input.is_action_just_released("ui_climb_down"):
				dashing = false
		if Input.is_action_pressed("ui_open"):
			if dialogueRange == true:
				if canDialogueBeUsed == true:
					$RichTextLabel.text = str(dialoguePart)
					if dialoguePart == -1:
						$"MarginContainer/HBoxContainer/Dialogue".hide()
					elif dialoguePart == 0:
						dialoguePart = 1
						$"MarginContainer/HBoxContainer/Dialogue".show()
						canDialogueBeUsed = false
						$Timer6.start()
					elif dialoguePart == 1:
						$"MarginContainer/HBoxContainer/Dialogue".texture = dialogue_dungeon_1
						dialoguePart = 2
						$"MarginContainer/HBoxContainer/Dialogue".show()
						canDialogueBeUsed = false
						$Timer6.start()
					elif dialoguePart == 2:
						$"MarginContainer/HBoxContainer/Dialogue".texture = dialogue_dungeon_2
						dialoguePart = 3
						$"MarginContainer/HBoxContainer/Dialogue".show()
						canDialogueBeUsed = false
						$Timer6.start()
					elif dialoguePart == 3:
						$"MarginContainer/HBoxContainer/Dialogue".texture = dialogue_dungeon_3
						dialoguePart = 4
						$"MarginContainer/HBoxContainer/Dialogue".show()
						canDialogueBeUsed = false
						$Timer6.start()
					elif dialoguePart == 4:
						$"MarginContainer/HBoxContainer/Dialogue".texture = dialogue_dungeon_4
						dialoguePart = 5
						$"MarginContainer/HBoxContainer/Dialogue".show()
						canDialogueBeUsed = false
						$Timer6.start()
					elif dialoguePart == 5:
						$"MarginContainer/HBoxContainer/Dialogue".texture = dialogue_dungeon_5
						dialoguePart = 6
						$"MarginContainer/HBoxContainer/Dialogue".show()
						canDialogueBeUsed = false
						$Timer6.start()
					elif dialoguePart == 6:
						$"MarginContainer/HBoxContainer/Dialogue".texture = dialogue_dungeon_6
						dialoguePart = -1
						$"MarginContainer/HBoxContainer/Dialogue".show()
						canDialogueBeUsed = false
						$Timer6.start()
						
					elif dialoguePart == 7:
						$"MarginContainer/HBoxContainer/Dialogue".texture = dialogue_enemybase_s_1
						dialoguePart = 8
						$"MarginContainer/HBoxContainer/Dialogue".show()
						canDialogueBeUsed = false
						$Timer6.start()
					elif dialoguePart == 8:
						$"MarginContainer/HBoxContainer/Dialogue".texture = dialogue_enemybase_s_2
						dialoguePart = 9
						$"MarginContainer/HBoxContainer/Dialogue".show()
						canDialogueBeUsed = false
						$Timer6.start()
					elif dialoguePart == 9:
						$"MarginContainer/HBoxContainer/Dialogue".texture = dialogue_enemybase_s_3
						dialoguePart = 10
						$"MarginContainer/HBoxContainer/Dialogue".show()
						canDialogueBeUsed = false
						$Timer6.start()
					elif dialoguePart == 10:
						$"MarginContainer/HBoxContainer/Dialogue".texture = dialogue_enemybase_s_4
						dialoguePart = 11
						$"MarginContainer/HBoxContainer/Dialogue".show()
						canDialogueBeUsed = false
						$Timer6.start()
					elif dialoguePart == 11:
						$"MarginContainer/HBoxContainer/Dialogue".texture = dialogue_enemybase_s_5
						dialoguePart = -1
						$"MarginContainer/HBoxContainer/Dialogue".show()
						canDialogueBeUsed = false
						$Timer6.start()
						
					elif dialoguePart == 12:
						$"MarginContainer/HBoxContainer/Dialogue".texture = dialogue_enemybase_g_1
						dialoguePart = -1
						$"MarginContainer/HBoxContainer/Dialogue".show()
						canDialogueBeUsed = false
						$Timer6.start()
						
					if dialoguePart == 13:
						$"MarginContainer/HBoxContainer/Dialogue".texture = dialogue_breach_1
						dialoguePart = 14
						$"MarginContainer/HBoxContainer/Dialogue".show()
						canDialogueBeUsed = false
						$Timer6.start()
					elif dialoguePart == 14:
						$"MarginContainer/HBoxContainer/Dialogue".texture = dialogue_breach_2
						dialoguePart = 15
						$"MarginContainer/HBoxContainer/Dialogue".show()
						canDialogueBeUsed = false
						$Timer6.start()
					elif dialoguePart == 15:
						$"MarginContainer/HBoxContainer/Dialogue".texture = dialogue_breach_3
						dialoguePart = 16
						$"MarginContainer/HBoxContainer/Dialogue".show()
						canDialogueBeUsed = false
						$Timer6.start()
					elif dialoguePart == 16:
						$"MarginContainer/HBoxContainer/Dialogue".texture = dialogue_breach_4
						dialoguePart = 17
						$"MarginContainer/HBoxContainer/Dialogue".show()
						canDialogueBeUsed = false
						$Timer6.start()
					elif dialoguePart == 17:
						$"MarginContainer/HBoxContainer/Dialogue".texture = dialogue_breach_5
						dialoguePart = 18
						$"MarginContainer/HBoxContainer/Dialogue".show()
						canDialogueBeUsed = false
						$Timer6.start()
					elif dialoguePart == 18:
						$"MarginContainer/HBoxContainer/Dialogue".texture = dialogue_breach_6
						dialoguePart = 19
						$"MarginContainer/HBoxContainer/Dialogue".show()
						canDialogueBeUsed = false
						$Timer6.start()
					elif dialoguePart == 19:
						$"MarginContainer/HBoxContainer/Dialogue".texture = dialogue_breach_7
						dialoguePart = 20
						$"MarginContainer/HBoxContainer/Dialogue".show()
						canDialogueBeUsed = false
						$Timer6.start()
					elif dialoguePart == 20:
						$"MarginContainer/HBoxContainer/Dialogue".texture = dialogue_breach_8
						dialoguePart = 21
						$"MarginContainer/HBoxContainer/Dialogue".show()
						canDialogueBeUsed = false
						$Timer6.start()
					elif dialoguePart == 21:
						$"MarginContainer/HBoxContainer/Dialogue".texture = dialogue_breach_9
						dialoguePart = 22
						$"MarginContainer/HBoxContainer/Dialogue".show()
						canDialogueBeUsed = false
						$Timer6.start()
					elif dialoguePart == 22:
						$"MarginContainer/HBoxContainer/Dialogue".texture = dialogue_breach_10
						dialoguePart = 23
						$"MarginContainer/HBoxContainer/Dialogue".show()
						canDialogueBeUsed = false
						$Timer6.start()
					elif dialoguePart == 23:
						$"MarginContainer/HBoxContainer/Dialogue".texture = dialogue_breach_11
						dialoguePart = 24
						$"MarginContainer/HBoxContainer/Dialogue".show()
						canDialogueBeUsed = false
						$Timer6.start()
					elif dialoguePart == 24:
						$"MarginContainer/HBoxContainer/Dialogue".texture = dialogue_breach_12
						dialoguePart = 25
						$"MarginContainer/HBoxContainer/Dialogue".show()
						canDialogueBeUsed = false
						$Timer6.start()
					elif dialoguePart == 25:
						$"MarginContainer/HBoxContainer/Dialogue".texture = dialogue_breach_13
						dialoguePart = 26
						$"MarginContainer/HBoxContainer/Dialogue".show()
						canDialogueBeUsed = false
						$Timer6.start()
					elif dialoguePart == 26:
						$"MarginContainer/HBoxContainer/Dialogue".texture = dialogue_breach_14
						dialoguePart = 27
						$"MarginContainer/HBoxContainer/Dialogue".show()
						canDialogueBeUsed = false
						$Timer6.start()
					elif dialoguePart == 27:
						$"MarginContainer/HBoxContainer/Dialogue".texture = dialogue_breach_15
						dialoguePart = 28
						$"MarginContainer/HBoxContainer/Dialogue".show()
						canDialogueBeUsed = false
						$Timer6.start()
					elif dialoguePart == 28:
						$"MarginContainer/HBoxContainer/Dialogue".texture = dialogue_breach_16
						dialoguePart = 29
						$"MarginContainer/HBoxContainer/Dialogue".show()
						canDialogueBeUsed = false
						$Timer6.start()
					elif dialoguePart == 29:
						$"MarginContainer/HBoxContainer/Dialogue".texture = dialogue_breach_17
						dialoguePart = 30
						$"MarginContainer/HBoxContainer/Dialogue".show()
						canDialogueBeUsed = false
						$Timer6.start()
					elif dialoguePart == 30:
						$"MarginContainer/HBoxContainer/Dialogue".texture = dialogue_breach_18
						dialoguePart = 31
						$"MarginContainer/HBoxContainer/Dialogue".show()
						canDialogueBeUsed = false
						$Timer6.start()
					elif dialoguePart == 31:
						$"MarginContainer/HBoxContainer/Dialogue".texture = dialogue_breach_19
						dialoguePart = 32
						$"MarginContainer/HBoxContainer/Dialogue".show()
						canDialogueBeUsed = false
						$Timer6.start()
					elif dialoguePart == 32:
						$"MarginContainer/HBoxContainer/Dialogue".texture = dialogue_breach_20
						dialoguePart = -1
						$"MarginContainer/HBoxContainer/Dialogue".show()
						canDialogueBeUsed = false
						$Timer6.start()
						
					
			elif dialogueRange == false:
				$"MarginContainer/HBoxContainer/Dialogue".hide()
			if isInRangeOfSign == true:
				if signID == "1_1":
					$"MarginContainer/HBoxContainer/Sign".texture = sign1_1
				elif signID == "1_2":
					$"MarginContainer/HBoxContainer/Sign".texture = sign1_2
				elif signID == "2_1":
					$"MarginContainer/HBoxContainer/Sign".texture = sign2_1
				elif signID == "5_1":
					$"MarginContainer/HBoxContainer/Sign".texture = sign5_1
				elif signID == "5_2":
					$"MarginContainer/HBoxContainer/Sign".texture = sign5_2
				elif signID == "5_3":
					$"MarginContainer/HBoxContainer/Sign".texture = sign5_3
				elif signID == "6_1":
					$"MarginContainer/HBoxContainer/Sign".texture = sign6_1
				elif signID == "8_1":
					$"MarginContainer/HBoxContainer/Sign".texture = sign8_1
				else:
					$"MarginContainer/HBoxContainer/Sign".texture = sign_error
				$"MarginContainer/HBoxContainer/Sign".show()
				signOpened = true
			if isUsingLadder == false:
				if canChangeLadderState == true:
					if isOnLadder == true:
						isUsingLadder = true
						canChangeLadderState = false
						$Timer7.start()
						self_y = self.position.y
						position = position.move_toward(Vector2(get_node("../Ladder").position.x, self_y), delta * 50)
			elif isUsingLadder == true:
				if canChangeLadderState == true:
					canChangeLadderState = false
					$Timer7.start()
					isUsingLadder = false
			
				
		if Input.is_action_pressed("ui_right"):
			if Is_Attacking == false:
				if dashableStateChangable == true:
					if dashable == false:
						$Timer8.start()
						dashable = true
				if dashing == false:
					velocity.x = Speed
				if on_ground == true:
					$AnimatedSprite.play("walk") 
					$AnimatedSprite.flip_h = false
					Direction = 1
				$Position2D.position.x = 13
				FS = 1
		elif Input.is_action_pressed("ui_left"):
			if Is_Attacking == false:
				if dashableStateChangable == true:
					if dashable == false:
						$Timer8.start()
						dashable = true
				if dashing == false:
					velocity.x = -Speed
				if on_ground == true:
					$AnimatedSprite.play("walk") 
					$AnimatedSprite.flip_h = true
					Direction = -1
				$Position2D.position.x = -13
				FS = -1
		elif Input.is_action_just_pressed("ui_up"):
			if active_movement_ability == 1:
				if Is_Attacking == false:
					if can_change_jc == true:
						if jump_count < 2:
							if jump_count == 1:
								var jumpSmoke = JumpSmoke.instance()
								get_parent().add_child(jumpSmoke)
								jumpSmoke.position = $Position2D2.global_position
								jumpSmoke.timestart()
							can_change_jc = false
							$Timer9.start()
							velocity.y = JumpPower
							on_ground = false
							jump_count = jump_count + 1
		elif Input.is_action_pressed("ui_up"):
			if active_movement_ability > 1:
				if Is_Attacking == false:
					if on_ground == true:
						velocity.y = JumpPower
						on_ground = false
#		elif Input.is_action_pressed("ui_up"):
#			if Is_Attacking == false:
#				if active_movement_ability == 1:
#					if can_change_jc == true:
#						if jump_count < 2:
#							if jump_count == 1:
#								var jumpSmoke = JumpSmoke.instance()
#								get_parent().add_child(jumpSmoke)
#								jumpSmoke.position = $Position2D2.global_position
#								jumpSmoke.timestart()
#							can_change_jc = false
#							$Timer9.start()
#							velocity.y = JumpPower
#							on_ground = false
#							jump_count = jump_count + 1 
#				elif on_ground == true:
#					velocity.y = JumpPower
#					on_ground = false
					
		else:
			if Is_Attacking == false:
				if dashing == false:
					velocity.x = 0
				if on_ground == true:
					$AnimatedSprite.play("idle")
		if Input.is_action_pressed("ui_left"):
			if Is_Attacking == false:
				if dashableStateChangable == true:
					if dashable == false:
						$Timer8.start()
						dashable = true
				if dashing == false:
					velocity.x = -Speed
				if on_ground == true:
					$AnimatedSprite.play("walk") 
					$AnimatedSprite.flip_h = true
				$Position2D.position.x = -13
				FS = -1
		elif Input.is_action_pressed("ui_right"):
			if Is_Attacking == false:
				if dashableStateChangable == true:
					if dashable == false:
						$Timer8.start()
						dashable = true
				if dashing == false:
					velocity.x = Speed
				if on_ground == true:
					$AnimatedSprite.play("walk") 
					$AnimatedSprite.flip_h = false
				$Position2D.position.x = 13
				FS = 1
		elif Input.is_action_just_pressed("ui_up"):
			if active_movement_ability == 1:
				if Is_Attacking == false:
					if can_change_jc == true:
						if jump_count < 2:
							if jump_count == 1:
								var jumpSmoke = JumpSmoke.instance()
								get_parent().add_child(jumpSmoke)
								jumpSmoke.position = $Position2D2.global_position
								jumpSmoke.timestart()
							can_change_jc = false
							$Timer9.start()
							velocity.y = JumpPower
							on_ground = false
							jump_count = jump_count + 1
		elif Input.is_action_pressed("ui_up"):
			if active_movement_ability > 1:
				if Is_Attacking == false:
					if on_ground == true:
						velocity.y = JumpPower
						on_ground = false
#		elif Input.is_action_pressed("ui_up"):
#			if Is_Attacking == false:
#				if active_movement_ability == 1:
#					if can_change_jc == true:
#						if jump_count < 2:
#							if jump_count == 1:
#								var jumpSmoke = JumpSmoke.instance()
#								get_parent().add_child(jumpSmoke)
#								jumpSmoke.position = $Position2D2.global_position
#								jumpSmoke.timestart()
#							can_change_jc = false
#							$Timer9.start()
#							velocity.y = JumpPower
#							on_ground = false
#							jump_count = jump_count + 1 
#				elif on_ground == true:
#					velocity.y = JumpPower
#					on_ground = false
		else:
			if Is_Attacking == false:
				if dashing == false:
					velocity.x = 0
				if on_ground == true:
					$AnimatedSprite.play("idle")
		if Input.is_action_just_pressed("ui_up"):
			if active_movement_ability == 1:
				if Is_Attacking == false:
					if can_change_jc == true:
						if jump_count < 2:
							if jump_count == 1:
								var jumpSmoke = JumpSmoke.instance()
								get_parent().add_child(jumpSmoke)
								jumpSmoke.position = $Position2D2.global_position
								jumpSmoke.timestart()
							can_change_jc = false
							$Timer9.start()
							velocity.y = JumpPower
							on_ground = false
							jump_count = jump_count + 1
		elif Input.is_action_pressed("ui_up"):
			if active_movement_ability > 1:
				if Is_Attacking == false:
					if on_ground == true:
						velocity.y = JumpPower
						on_ground = false
#		if Input.is_action_pressed("ui_up"):
#			if Is_Attacking == false:
#				if active_movement_ability == 1:
#					if can_change_jc == true:
#						if jump_count < 2:
#							if jump_count == 1:
#								var jumpSmoke = JumpSmoke.instance()
#								get_parent().add_child(jumpSmoke)
#								jumpSmoke.position = $Position2D2.global_position
#								jumpSmoke.timestart()
#							can_change_jc = false
#							$Timer9.start()
#							velocity.y = JumpPower
#							on_ground = false
#							jump_count = jump_count + 1 
#				elif on_ground == true:
#					velocity.y = JumpPower
#					on_ground = false
		elif Input.is_action_pressed("ui_right"):
			if Is_Attacking == false:
				if dashableStateChangable == true:
					if dashable == false:
						$Timer8.start()
						dashable = true
				if dashing == false:
					velocity.x = Speed
				if on_ground == true:
					$AnimatedSprite.play("walk") 
					$AnimatedSprite.flip_h = false
				$Position2D.position.x = 13
				FS = 1
		elif Input.is_action_pressed("ui_left"):
			if Is_Attacking == false:
				if dashableStateChangable == true:
					if dashable == false:
						$Timer8.start()
						dashable = true
				if dashing == false:
					velocity.x = -Speed
				if on_ground == true:
					$AnimatedSprite.play("walk") 
					$AnimatedSprite.flip_h = true
				$Position2D.position.x = -13
				FS = -1
		else:
			if Is_Attacking == false:
				if dashing == false:
					velocity.x = 0
				if on_ground == true:
					$AnimatedSprite.play("idle") 
			
			
		if Input.is_action_just_pressed("ui_shoot") && Is_Attacking == false:
			Is_Attacking = true
			velocity.x = 0
			if active_ability == 1:
				if global_variables.leviathanBeaten == false:
					var fireball = Fireball.instance()
					if FS == 1:
						fireball.set_fireball_direction(1)
					else:
						fireball.set_fireball_direction(-1)
					get_parent().add_child(fireball)
					fireball.position = $Position2D.global_position
					$AnimatedSprite.play("shoot")
				elif global_variables.leviathanBeaten == true:
					var breachball = Breachball.instance()
					if FS == 1:
						breachball.set_fireball_direction(1)
					else:
						breachball.set_fireball_direction(-1)
					get_parent().add_child(breachball)
					breachball.position = $Position2D.global_position
					$AnimatedSprite.play("breachshoot")
			elif active_ability == 2:
				$AnimatedSprite.play("punch")
				$Area2D2/CollisionShape2D.disabled = false
				$Timer4.start()
			elif active_ability == 3:
				$AnimatedSprite.play("talonstab")
				$Area2D2/CollisionShape2D.disabled = false
				$Timer4.start()
					
		if Input.is_action_just_pressed("ui_switch-abilities"):
			active_ability += 1
		if Input.is_action_just_pressed("ui_switch_movement_abilities"):
			active_movement_ability += 1
			
		if Input.is_action_just_pressed("ui_pause"):
			if signOpened == true:
				$"MarginContainer/HBoxContainer/Sign".hide()
			else:
				pausemenushown = pausemenushown * -1
				if pausemenushown == 1:
					$MarginContainer2.show()
				elif pausemenushown == -1:
					$MarginContainer2.hide()
		velocity.y = velocity.y + Grav
		var new_file = File.new()
		# See if there is a savegame to load, else stop
		if not new_file.file_exists("res://savegame.txt"):
			return
		# Read the contents of the savegame
		new_file.open("res://savegame.txt", File.READ)
		# Assign a variable to the contents of the file
		# get_as_text() means it's in the form of a string
		var data = new_file.get_as_text()
		# Close the File, as we don't need it anymore
		new_file.close()
		#$RichTextLabel.text = str(data)
		if lifesteal_unlocked == false:
#			$RichTextLabel.text = "Da"
			if active_ability > 2:
				active_ability = 1
			if active_ability < 0:
				active_ability = 2
		elif lifesteal_unlocked == true:
			if active_ability > 3:
				active_ability = 1
			if active_ability < 0:
				active_ability = 3
		
		if dash_unlocked == false:
			if active_movement_ability > 1:
				active_movement_ability = 1
			if active_movement_ability < 0:
				active_movement_ability = 1
		elif dash_unlocked == true:
			if active_movement_ability > 2:
				active_movement_ability = 1
			if active_movement_ability < 0:
				active_movement_ability = 2

		if active_ability == 1:
			if global_variables.leviathanBeaten == false:
				get_node("MarginContainer/HBoxContainer/Active Ability").set_texture(abil_pb)
			elif global_variables.leviathanBeaten == true:
				get_node("MarginContainer/HBoxContainer/Active Ability").set_texture(abil_bb)
		elif active_ability == 2:
			get_node("MarginContainer/HBoxContainer/Active Ability").set_texture(abil_punch)
		elif active_ability == 3:
			get_node("MarginContainer/HBoxContainer/Active Ability").set_texture(abil_talon)

		if active_movement_ability == 1:
			get_node("MarginContainer/HBoxContainer/Active Movement Ability").set_texture(abil_djump)
		elif active_movement_ability == 2:
			get_node("MarginContainer/HBoxContainer/Active Movement Ability").set_texture(abil_dash)
	
		if is_on_floor():
			on_ground = true
			jump_count = 0
			
		else:
			if on_ground == true:
				on_ground = false
				jump_count = 1
			if isUsingLadder == false:
				if velocity.y < 0:
					$AnimatedSprite.play("jump")
				else:
					$AnimatedSprite.play("fall")  

		velocity = move_and_slide(velocity, Floor)
	else:
		dead()
func _on_AnimatedSprite_animation_finished():
	Is_Attacking = false

func _on_Area2D_body_entered(body):
	if body.name == "Fiery Goliath":
		body.leave_player_head()
	elif body.name == "SoldierEnemy":
		body.leave_player_head()
	elif body.name == "Quantum Slayer":
		body.leave_player_head()


func _on_Timer_timeout():
	get_parent().get_node("PlayerVarHolder").PlayerAlive = false
	queue_free()
	


func _on_Timer2_timeout():
	if HP == 12:
		get_node("MarginContainer/HBoxContainer/Heart_13").set_texture(health_bonus_no_ubercharge)
	elif HP == 11:
		get_node("MarginContainer/HBoxContainer/Heart_13").set_texture(health_bonus_no_ubercharge)
		get_node("MarginContainer/HBoxContainer/Heart_12").set_texture(health_bonus_no_ubercharge)
	elif HP == 10:
		get_node("MarginContainer/HBoxContainer/Heart_13").set_texture(health_bonus_no_ubercharge)
		get_node("MarginContainer/HBoxContainer/Heart_12").set_texture(health_bonus_no_ubercharge)
		get_node("MarginContainer/HBoxContainer/Heart_11").set_texture(health_bonus_no_ubercharge)
	elif HP == 9:
		get_node("MarginContainer/HBoxContainer/Heart_13").set_texture(health_bonus_no_ubercharge)
		get_node("MarginContainer/HBoxContainer/Heart_12").set_texture(health_bonus_no_ubercharge)
		get_node("MarginContainer/HBoxContainer/Heart_11").set_texture(health_bonus_no_ubercharge)
		get_node("MarginContainer/HBoxContainer/Heart_10").set_texture(health_bonus_no_texture)
	elif HP == 8:
		get_node("MarginContainer/HBoxContainer/Heart_13").set_texture(health_bonus_no_ubercharge)
		get_node("MarginContainer/HBoxContainer/Heart_12").set_texture(health_bonus_no_ubercharge)
		get_node("MarginContainer/HBoxContainer/Heart_11").set_texture(health_bonus_no_ubercharge)
		get_node("MarginContainer/HBoxContainer/Heart_10").set_texture(health_bonus_no_texture)
		get_node("MarginContainer/HBoxContainer/Heart_9").set_texture(health_bonus_no_texture)
	elif HP == 7:
		get_node("MarginContainer/HBoxContainer/Heart_13").set_texture(health_bonus_no_ubercharge)
		get_node("MarginContainer/HBoxContainer/Heart_12").set_texture(health_bonus_no_ubercharge)
		get_node("MarginContainer/HBoxContainer/Heart_11").set_texture(health_bonus_no_ubercharge)
		get_node("MarginContainer/HBoxContainer/Heart_10").set_texture(health_bonus_no_texture)
		get_node("MarginContainer/HBoxContainer/Heart_9").set_texture(health_bonus_no_texture)
		get_node("MarginContainer/HBoxContainer/Heart_8").set_texture(health_bonus_no_texture)
	elif HP == 6:
		get_node("MarginContainer/HBoxContainer/Heart_13").set_texture(health_bonus_no_ubercharge)
		get_node("MarginContainer/HBoxContainer/Heart_12").set_texture(health_bonus_no_ubercharge)
		get_node("MarginContainer/HBoxContainer/Heart_11").set_texture(health_bonus_no_ubercharge)
		get_node("MarginContainer/HBoxContainer/Heart_10").set_texture(health_bonus_no_texture)
		get_node("MarginContainer/HBoxContainer/Heart_9").set_texture(health_bonus_no_texture)
		get_node("MarginContainer/HBoxContainer/Heart_8").set_texture(health_bonus_no_texture)
		get_node("MarginContainer/HBoxContainer/Heart_7").set_texture(health_bonus_no_texture)
	elif HP == 5:
		get_node("MarginContainer/HBoxContainer/Heart_13").set_texture(health_bonus_no_ubercharge)
		get_node("MarginContainer/HBoxContainer/Heart_12").set_texture(health_bonus_no_ubercharge)
		get_node("MarginContainer/HBoxContainer/Heart_11").set_texture(health_bonus_no_ubercharge)
		get_node("MarginContainer/HBoxContainer/Heart_10").set_texture(health_bonus_no_texture)
		get_node("MarginContainer/HBoxContainer/Heart_9").set_texture(health_bonus_no_texture)
		get_node("MarginContainer/HBoxContainer/Heart_8").set_texture(health_bonus_no_texture)
		get_node("MarginContainer/HBoxContainer/Heart_7").set_texture(health_bonus_no_texture)
		get_node("MarginContainer/HBoxContainer/Heart_6").set_texture(health_bonus_no_texture)
	elif HP == 4:
		get_node("MarginContainer/HBoxContainer/Heart_13").set_texture(health_bonus_no_ubercharge)
		get_node("MarginContainer/HBoxContainer/Heart_12").set_texture(health_bonus_no_ubercharge)
		get_node("MarginContainer/HBoxContainer/Heart_11").set_texture(health_bonus_no_ubercharge)
		get_node("MarginContainer/HBoxContainer/Heart_10").set_texture(health_bonus_no_texture)
		get_node("MarginContainer/HBoxContainer/Heart_9").set_texture(health_bonus_no_texture)
		get_node("MarginContainer/HBoxContainer/Heart_8").set_texture(health_bonus_no_texture)
		get_node("MarginContainer/HBoxContainer/Heart_7").set_texture(health_bonus_no_texture)
		get_node("MarginContainer/HBoxContainer/Heart_6").set_texture(health_bonus_no_texture)
		get_node("MarginContainer/HBoxContainer/Heart_5").set_texture(health_no_texture)
	elif HP == 3:
		get_node("MarginContainer/HBoxContainer/Heart_13").set_texture(health_bonus_no_ubercharge)
		get_node("MarginContainer/HBoxContainer/Heart_12").set_texture(health_bonus_no_ubercharge)
		get_node("MarginContainer/HBoxContainer/Heart_11").set_texture(health_bonus_no_ubercharge)
		get_node("MarginContainer/HBoxContainer/Heart_10").set_texture(health_bonus_no_texture)
		get_node("MarginContainer/HBoxContainer/Heart_9").set_texture(health_bonus_no_texture)
		get_node("MarginContainer/HBoxContainer/Heart_8").set_texture(health_bonus_no_texture)
		get_node("MarginContainer/HBoxContainer/Heart_7").set_texture(health_bonus_no_texture)
		get_node("MarginContainer/HBoxContainer/Heart_6").set_texture(health_bonus_no_texture)
		get_node("MarginContainer/HBoxContainer/Heart_5").set_texture(health_no_texture)
		get_node("MarginContainer/HBoxContainer/Heart_4").set_texture(health_no_texture)
	elif HP == 2:
		get_node("MarginContainer/HBoxContainer/Heart_13").set_texture(health_bonus_no_ubercharge)
		get_node("MarginContainer/HBoxContainer/Heart_12").set_texture(health_bonus_no_ubercharge)
		get_node("MarginContainer/HBoxContainer/Heart_11").set_texture(health_bonus_no_ubercharge)
		get_node("MarginContainer/HBoxContainer/Heart_10").set_texture(health_bonus_no_texture)
		get_node("MarginContainer/HBoxContainer/Heart_9").set_texture(health_bonus_no_texture)
		get_node("MarginContainer/HBoxContainer/Heart_8").set_texture(health_bonus_no_texture)
		get_node("MarginContainer/HBoxContainer/Heart_7").set_texture(health_bonus_no_texture)
		get_node("MarginContainer/HBoxContainer/Heart_6").set_texture(health_bonus_no_texture)
		get_node("MarginContainer/HBoxContainer/Heart_5").set_texture(health_no_texture)
		get_node("MarginContainer/HBoxContainer/Heart_4").set_texture(health_no_texture)
		get_node("MarginContainer/HBoxContainer/Heart_3").set_texture(health_no_texture)
	elif HP == 1:
		get_node("MarginContainer/HBoxContainer/Heart_13").set_texture(health_bonus_no_ubercharge)
		get_node("MarginContainer/HBoxContainer/Heart_12").set_texture(health_bonus_no_ubercharge)
		get_node("MarginContainer/HBoxContainer/Heart_11").set_texture(health_bonus_no_ubercharge)
		get_node("MarginContainer/HBoxContainer/Heart_10").set_texture(health_bonus_no_texture)
		get_node("MarginContainer/HBoxContainer/Heart_9").set_texture(health_bonus_no_texture)
		get_node("MarginContainer/HBoxContainer/Heart_8").set_texture(health_bonus_no_texture)
		get_node("MarginContainer/HBoxContainer/Heart_7").set_texture(health_bonus_no_texture)
		get_node("MarginContainer/HBoxContainer/Heart_6").set_texture(health_bonus_no_texture)
		get_node("MarginContainer/HBoxContainer/Heart_5").set_texture(health_no_texture)
		get_node("MarginContainer/HBoxContainer/Heart_4").set_texture(health_no_texture)
		get_node("MarginContainer/HBoxContainer/Heart_3").set_texture(health_no_texture)
		get_node("MarginContainer/HBoxContainer/Heart_2").set_texture(health_no_texture)
	elif HP == 0:
		get_node("MarginContainer/HBoxContainer/Heart_13").set_texture(health_bonus_no_texture)
		get_node("MarginContainer/HBoxContainer/Heart_12").set_texture(health_bonus_no_texture)
		get_node("MarginContainer/HBoxContainer/Heart_11").set_texture(health_bonus_no_texture)
		get_node("MarginContainer/HBoxContainer/Heart_10").set_texture(health_bonus_no_texture)
		get_node("MarginContainer/HBoxContainer/Heart_9").set_texture(health_bonus_no_texture)
		get_node("MarginContainer/HBoxContainer/Heart_8").set_texture(health_bonus_no_texture)
		get_node("MarginContainer/HBoxContainer/Heart_7").set_texture(health_bonus_no_texture)
		get_node("MarginContainer/HBoxContainer/Heart_6").set_texture(health_bonus_no_texture)
		get_node("MarginContainer/HBoxContainer/Heart_5").set_texture(health_no_texture)
		get_node("MarginContainer/HBoxContainer/Heart_4").set_texture(health_no_texture)
		get_node("MarginContainer/HBoxContainer/Heart_3").set_texture(health_no_texture)
		get_node("MarginContainer/HBoxContainer/Heart_2").set_texture(health_no_texture)
		get_node("MarginContainer/HBoxContainer/Heart_1").set_texture(health_no_texture)

func _on_Timer3_timeout():
	get_node("MarginContainer/HBoxContainer/Heart_13").set_texture(health_bonus_ubercharge)
	get_node("MarginContainer/HBoxContainer/Heart_12").set_texture(health_bonus_ubercharge)
	get_node("MarginContainer/HBoxContainer/Heart_11").set_texture(health_bonus_ubercharge)
	get_node("MarginContainer/HBoxContainer/Heart_10").set_texture(health_bonus_texture)
	get_node("MarginContainer/HBoxContainer/Heart_9").set_texture(health_bonus_texture)
	get_node("MarginContainer/HBoxContainer/Heart_8").set_texture(health_bonus_texture)
	get_node("MarginContainer/HBoxContainer/Heart_7").set_texture(health_bonus_texture)
	get_node("MarginContainer/HBoxContainer/Heart_6").set_texture(health_bonus_texture)
	get_node("MarginContainer/HBoxContainer/Heart_5").set_texture(health_texture)
	get_node("MarginContainer/HBoxContainer/Heart_4").set_texture(health_texture)
	get_node("MarginContainer/HBoxContainer/Heart_3").set_texture(health_texture)
	get_node("MarginContainer/HBoxContainer/Heart_2").set_texture(health_texture)
	get_node("MarginContainer/HBoxContainer/Heart_1").set_texture(health_texture)
	
func _on_Area2D_Lab_body_entered(body):
	if "Player1" in body.name:
		get_node("MarginContainer/HBoxContainer/Boss_HB").show()
		get_node("MarginContainer/HBoxContainer/Boss_HB").set_texture(goliath_full)


func _on_Area2D_Lab_body_exited(body):
	if "Player1" in body.name:
		get_node("MarginContainer/HBoxContainer/Boss_HB").hide()


func _on_Pit_body_entered(body):
	dead()


func _on_Area2D_Cave_body_entered(body):
	if "Player1" in body.name:
		get_node("MarginContainer/HBoxContainer/Boss_HB").show()
		get_node("MarginContainer/HBoxContainer/Boss_HB").set_texture(goliath_full)


func _on_Area2D2_body_entered(body):
	if active_ability == 2:
		if "SoldierEnemy" in body.name:
			body.hurt(1)
		elif "Fiery Goliath" in body.name:
			body.hurt(2)
		elif "Quantum Slayer" in body.name:
			body.hurt(2)
		elif "Snake" in body.name:
			body.hurt(1)
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
			
	elif active_ability == 3:
		if "SoldierEnemy" in body.name:
			body.taloned = true
			body.hurt(0.5)
		elif "Fiery Goliath" in body.name:
			body.taloned = true
			body.hurt(1)
		elif "Quantum Slayer" in body.name:
			body.hurt(1)
		elif "Snake" in body.name:
			body.taloned = true
			body.hurt(0.5)
		elif "Bat" in body.name:
			body.taloned = true
			body.dead()
		elif "Dummy" in body.name:
			body.taloned = true
			body.hurt(0.5)
		elif "Tumbleblade" in body.name:
			body.taloned = true
			body.hurt(0.5)
		elif "Blighteye" in body.name:
			body.taloned = true
			body.hurt(0.5)
		elif "Blightspitter" in body.name:
			body.taloned = true
			body.hurt(0.5)
		elif "Blightpack" in body.name:
			body.taloned = true
			body.hurt(0.5)
		elif "Blightmother" in body.name:
			body.taloned = true
			body.hurt(0.5)
		elif "Boomba" in body.name:
			body.taloned = true
			body.hurt(0.5)
		elif "Shooting Roomba" in body.name:
			body.taloned = true
			body.hurt(0.5)
		elif "Breachling" in body.name:
			body.taloned = true
			body.hurt(0.5)
		elif "Leviathan" in body.name:
			body.taloned = true
			body.hurt(1)


func _on_Timer4_timeout():
	$Area2D2/CollisionShape2D.disabled = true


func _on_TextureButton2_pressed():
	get_tree().reload_current_scene()


func _on_TextureButton3_pressed():
	get_tree().change_scene("res://TitleScreen.tscn")


func _on_TextureButton4_pressed():
	get_tree().quit()


func _on_Timer5_timeout():
	Is_Attacking = false


func _on_Desert_Arena_body_entered(body):
	if "Player1" in body.name:
		get_node("MarginContainer/HBoxContainer/Boss_HB").show()
		get_node("MarginContainer/HBoxContainer/Boss_HB").set_texture(tumbleblade_full)


func _on_Desert_Arena_body_exited(body):
	if "Player1" in body.name:
		get_node("MarginContainer/HBoxContainer/Boss_HB").hide()


func _on_Timer6_timeout():
	if canDialogueBeUsed == false:
		canDialogueBeUsed = true
	if canSignBeUsed == false:
		canSignBeUsed = true


func _on_Ladder_body_entered(body):
	if body.name == "Player1":
		isOnLadder = true


func _on_Ladder_body_exited(body):
	if body.name == "Player1":
		isOnLadder = false
		isUsingLadder = false


func _on_Timer7_timeout():
	canChangeLadderState = true

func _on_Timer8_timeout():
	dashable = false


func _on_Timer9_timeout():
	can_change_jc = true


func _on_Timer10_timeout():
	shadow_spawnable = true


func _on_Timer11_timeout():
	can_dash = false
	dashing = false
	timer_started = false
	$Timer12.start()

func _on_Timer12_timeout():
	can_dash = true


func _on_Timer13_timeout():
	$MarginContainer/HBoxContainer/Achievement.hide()
			
func _on_Timer14_timeout():
	if dashDialogueActivated == false:
		if get_parent().name == "DesertLevel5":
			$MarginContainer/HBoxContainer/Dialogue.texture = dialogue_5
			dialoguePart = -1
			$MarginContainer/HBoxContainer/Dialogue.show()
			canDialogueBeUsed = false
			dashDialogueActivated = true
			$Timer6.start()



func _on_Area2D_DSC_body_entered(body):
	if body.name == "Player1":
		get_node("MarginContainer/HBoxContainer/Boss_HB").show()
		get_node("MarginContainer/HBoxContainer/Boss_HB_2").show()
		get_node("MarginContainer/HBoxContainer/Boss_HB").set_texture(blightmother_full)
		get_node("MarginContainer/HBoxContainer/Boss_HB_2").set_texture(blightpack_full)


func _on_Area2D_DSC_body_exited(body):
	if body.name == "Player1":
		get_node("MarginContainer/HBoxContainer/Boss_HB").hide()
		get_node("MarginContainer/HBoxContainer/Boss_HB_2").hide()




func _on_Area2D_Breach_body_entered(body):
	if body.name == "Player1":
		get_node("MarginContainer/HBoxContainer/Boss_HB").show()
		get_node("MarginContainer/HBoxContainer/Boss_HB").set_texture(leviathan_24)


func _on_Area2D_Breach_body_exited(body):
	if body.name == "Player1":
		get_node("MarginContainer/HBoxContainer/Boss_HB").hide()


func _on_Timer16_timeout():
	if global_variables.unlock_sprite == 1:
		$Unlock/UnlockForeground.texture = Unlock1
	elif global_variables.unlock_sprite == 2:
		$Unlock/UnlockForeground.texture = Unlock2
	elif global_variables.unlock_sprite == 3:
		$Unlock/UnlockForeground.texture = Unlock3
#	if in_or_out == 1:
#		if $Unlock.modulate.a >= 0:
#			pass
#		else:
#			$Unlock.modulate.a += 0.01
#			$Timer16.start()
#	elif in_or_out == 2:
#		if $Unlock.modulate.a <= 1:
#			TransitionFinished = true
#		else:
#			$Unlock.modulate.a -= 0.01
#			$Timer16.start()
	if in_or_out == 1:
		if $Unlock.modulate.a < 1:
			$Unlock.modulate.a += 0.01
	elif in_or_out == 2:
		if $Unlock.modulate.a >= 0:
			$Unlock.modulate.a -= 0.01
	if $Unlock.modulate.a < 1 && $Unlock.modulate.a >= 0: 
		$Timer16.start()
	elif $Unlock.modulate.a < 0:
		$RichTextLabel.text = "fuck off"
	if arbitrary_value > 300:
		in_or_out = 2
	elif $Unlock.modulate.a >= 1:
		arbitrary_value += 1
		if arbitrary_value > 300:
			in_or_out = 2
#		$Timer17.start()
		$RichTextLabel.text = str(arbitrary_value)
		



func _on_Timer18_timeout():
	$AnimatedSprite.modulate.r = 1
	$AnimatedSprite.modulate.g = 1
	$AnimatedSprite.modulate.b = 1
