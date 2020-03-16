extends KinematicBody2D

class_name Player

func _ready():
	get_tree().call_group("Enemies", "set_player", self)
