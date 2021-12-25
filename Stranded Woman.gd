extends Node2D

var regular = preload("res://Placeholder Textures for Shards of the Past/npc/stranded_woman.png")
var highlighted = preload("res://Placeholder Textures for Shards of the Past/npc/stranded_woman_highlighted.png")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	if get_node("../Player1").position.x < self.position.x:
		$Sprite.flip_h = true
	elif get_node("../Player1").position.x > self.position.x:
		$Sprite.flip_h = false


func _on_Area2D_body_entered(body):
	if body.name == "Player1":
		$Sprite.texture = highlighted
		body.dialogueRange = true
		body.dialoguePart = 13


func _on_Area2D_body_exited(body):
	if body.name == "Player1":
		$Sprite.texture = regular
		body.dialogueRange = false
