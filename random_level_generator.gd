extends Node

class_name RandomLevelGenerator

var player: Player = null

func generate_new_roof(position: Vector2) -> Roof:
	var roof = preload("res://Roof/Roof.tscn").instance()
	roof.position = position
	return roof

func generate_random_roof(position: Vector2) -> Roof:
	var height = randf() * 100.0
	return generate_new_roof(Vector2(position.x, position.y + height))

var last_generated = 0.0

func _process(delta) -> void:
	if player == null:
		return
	
	while last_generated < player.position.x + 1000.0:
		var roof = generate_random_roof(Vector2(last_generated + randf() * 100.0, 0.0))
		last_generated = roof.position.x + 2 * roof.get_size().x
		add_child(roof)
