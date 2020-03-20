extends Node

class_name RandomLevelGenerator

var player: Player = null
var roofs: int = 0

func generate_new_roof(position: Vector2) -> Roof:
	var roof = preload("res://Roof/Roof.tscn").instance()
	roof.position = position
	return roof

func generate_random_roof(position: Vector2) -> Roof:
	var height =  randf() * 50.0 + 60.0
	#var height = 10.0
	return generate_new_roof(Vector2(position.x, position.y + height))

var last_generated = -1000.0

func generate_random_doctor(position: Vector2) -> PlagueDoctor:
	var doctor = preload("res://Enemies/PlagueDoctor/PlagueDoctor.tscn").instance()
	doctor.position = position
	doctor.position.x += randf() * 225.0
	doctor.position.y -= 27.0
	#Spawn Velocity
	#doctor.DXLIM = 3.0/(1.0+pow( 2.71828, -1/4*roofs)/0.2) 
	doctor.DXLIM = 0.75 + (roofs-30.0) / (25 + abs(roofs-30.0) )
	#print(doctor.DXLIM)
	doctor.set_player(player)
	return doctor

func _process(delta) -> void:
	if player == null:
		return
	
	while last_generated < player.position.x + 1000.0:
		roof_gen_routine()

func roof_gen_routine():
	var roof = generate_random_roof(Vector2(last_generated + randf() * 100.0, 0.0))
	last_generated = roof.position.x + 2 * roof.get_size().x
	add_child(roof)
	roofs+=1
	#Increase probability of more doctors appearing as you go further
	
	#p1 probability for multiple spawns
	#p2, probability for 3 spawns CONDITIONED on p1
	#Count roofs generated!
	var p1 = 100 - pow( 2.71828, -0.03125 * roofs )/0.007
	var p2 = 100 - pow( 2.71828, -0.015625 * roofs )/0.005
	
	var pdoctor = generate_random_doctor(roof.position)
	add_child(pdoctor)
	if ( randi()%100 <= p1) :
		var pdoctor2 = generate_random_doctor(roof.position)
		add_child(pdoctor2)
		if ( randi()%100 <= p2) :
			var pdoctor3 = generate_random_doctor(roof.position)
			add_child(pdoctor3)
	
