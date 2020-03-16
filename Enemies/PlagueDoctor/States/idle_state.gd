extends DummyIdleState

class_name PlagueDoctorIdleState

func get_distance_to_player() -> float:
	var player = variables["player"]
	var body = variables["body"]
	var distance_vec: Vector2 = player.global_position - body.global_position
	return distance_vec.length()

func can_see_player() -> bool:
	if variables.has("see_range") == false:
		return false
	if variables.has("player") == false:
		return false
	if variables.has("body") == false:
		return false
	
	var distance = get_distance_to_player()
	
	if distance > variables["see_range"]:
		return false
	
	return true

func process(delta) -> void:
	if can_see_player():
		emit_signal("change_state", "move_closer")
