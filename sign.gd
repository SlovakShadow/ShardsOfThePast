extends Node2D


var ID = "0_0"

# Called when the node enters the scene tree for the first time.
func _ready():
	if get_node("ID " + str(1) + "_" + str(1)):
		ID = "1_1"
	elif get_node("ID " + str(1) + "_" + str(2)):
		ID = "1_2"
	elif get_node("ID " + str(2) + "_" + str(1)):
		ID = "2_1"
	elif get_node("ID " + str(5) + "_" + str(1)):
		ID = "5_1"
	elif get_node("ID " + str(5) + "_" + str(2)):
		ID = "5_2"
	elif get_node("ID " + str(5) + "_" + str(3)):
		ID = "5_3"
	if get_node("ID " + str(6) + "_" + str(1)):
		ID = "6_1"
	if get_node("ID " + str(8) + "_" + str(1)):
		ID = "8_1"

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if body.name == "Player1":
		body.isInRangeOfSign = true
		body.signID = ID
		$Sprite2.show()


func _on_Area2D_body_exited(body):
	if body.name == "Player1":
		body.isInRangeOfSign = false
		$Sprite2.hide()
