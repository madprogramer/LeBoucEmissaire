extends Node2D

func _ready():
	get_node("RandomLevelGenerator").player = get_node("Player")
