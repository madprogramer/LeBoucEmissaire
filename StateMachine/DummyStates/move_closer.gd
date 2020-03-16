extends State

class_name DummyMoveCloserState

func is_close_to_player() -> bool:
	return false

func can_see_player() -> bool:
	return true

func process(delta) -> void:
	if !can_see_player():
		emit_signal("change_state", "lost_player")
	elif is_close_to_player():
		emit_signal("change_state", "attack")
	else:
		emit_signal("blip", {"type": "move_closer"})
