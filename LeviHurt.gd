extends KinematicBody2D

func hurt(amount):
	if get_parent().dead == false:
		get_parent().HP -= amount
