extends State

class_name DummyAttackState

func ready() -> void:
	emit_signal("blip", {"type": "change_animation", "animation": "attacking"})

func is_close_to_player() -> bool:
	return true

func can_see_player() -> bool:
	return true

func attack() -> void:
	emit_signal("blip", {"type": "attack", "attack": "dummy"})

func process(delta) -> void:
	if !can_see_player():
		emit_signal("change_state", "lost_player")
	elif is_close_to_player():
		attack()
	else:
		emit_signal("change_state", "move_closer")
