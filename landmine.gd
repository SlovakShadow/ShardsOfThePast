extends Node2D

onready var global_vars = get_node("/root/global_variables")
var type = 1

var achievement = preload("res://Placeholder Textures for Shards of the Past/achievements/into_the_stratosphere_card.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	if self.name.begins_with("Landmine"):
		type = 1
	elif self.name.begins_with("Proximity Mine"):
		type = 2


func explode():
	$Sprite/Particles2D.restart()
	$Timer.start()
	if global_vars.steppedOnMine == false:
		global_vars.steppedOnMine = true
		get_node("../Player1").achievement_recieved(achievement)

func _on_Area2D_body_entered(body):
	if body.name == "Player1":
		body.landmine_physics_override()
		explode()
		body.hurt(4)


func _on_Timer_timeout():
	queue_free()
