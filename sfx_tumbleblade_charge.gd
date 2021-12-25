extends AudioStreamPlayer2D

var sfx = preload("res://sfx/sounds/tumbleblade_charge.ogg")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _process(delta):
	if !self.is_playing():
		self.stream = sfx


func _on_noise_finished():
	queue_free()


func _on_Timer_timeout():
	queue_free()
