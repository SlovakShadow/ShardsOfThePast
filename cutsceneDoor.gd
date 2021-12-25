extends Sprite

var animationDoor = 1



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if animationDoor == 1:
		$cutsceneDoor.play("closed")
	elif animationDoor == 2:
		$cutsceneDoor.play("open")
	elif animationDoor == 3:
		$cutsceneDoor.play("close")
