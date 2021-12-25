extends Node2D
const SonicWave = preload("res://SonicWave.tscn")
var move = true


func _ready():
	get_node("Player1")._save()
