extends Node

class_name RandomLevelGenerator

var player: Player = null

func generate_new_roof(position: Vector2) -> Roof:
	var roof = preload("res://Roof/Roof.tscn").instance()
	roof.position = position
	return roof

func generate_random_roof(position: Vector2) -> Roof:
	var height = randf() * 50.0
	return generate_new_roof(Vector2(position.x, position.y + height))

var last_generated = -1000.0

func generate_random_doctor(position: Vector2) -> PlagueDoctor:
	var doctor = preload("res://Enemies/PlagueDoctor/PlagueDoctor.tscn").instance()
	doctor.position = position
	doctor.position.x += randf() * 200.0
	doctor.position.y -= 27.0
	doctor.set_player(player)
	return doctor

func _process(delta) -> void:
	if player == null:
		return
	
	while last_generated < player.position.x + 1000.0:
		var roof = generate_random_roof(Vector2(last_generated + randf() * 100.0, 0.0))
		last_generated = roof.position.x + 2 * roof.get_size().x
		add_child(roof)
		var pdoctor = generate_random_doctor(roof.position)
		add_child(pdoctor)
