extends DummyAttackState

class_name Enemy1AttackState

func ready() -> void:
	emit_signal("blip", {"type": "change_animation", "animation": "attacking"})

func get_distance_to_player() -> float:
	var player = variables["player"]
	var body = variables["body"]
	var distance_vec: Vector2 = player.global_position - body.global_position
	return distance_vec.length()

func is_close_to_player() -> bool:
	if variables.has("move_closer_range") == false:
		return false
	if variables.has("player") == false:
		return false
	if variables.has("body") == false:
		return false
	
	var distance = get_distance_to_player()
	
	if distance > variables["move_closer_range"]:
		return false
	
	return true

func can_see_player() -> bool:
	return true

func attack() -> void:
	emit_signal("blip", {"type": "attack", "attack": "melee"})

func process(delta) -> void:
	if !can_see_player():
		emit_signal("change_state", "lost_player")
	elif is_close_to_player():
		attack()
	else:
		emit_signal("change_state", "move_closer")
