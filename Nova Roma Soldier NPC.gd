extends Node2D

var regular = preload("res://Placeholder Textures for Shards of the Past/npc/NovaRomaSoldier.png")
var highlighted = preload("res://Placeholder Textures for Shards of the Past/npc/NovaRomaSoldier.png")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_Area2D_body_entered(body):
	if self.name == "Nova Roma Soldier NPC":
		if body.name == "Player1":
			$Sprite.texture = regular
			body.dialogueRange = true
#			if get_node("ID " + str(1)):
#				body.dialoguePart = 8


func _on_Area2D_body_exited(body):
	if self.name == "Nova Roma Soldier NPC":
		if body.name == "Player1":
			$Sprite.texture = regular
			body.dialogueRange = false
