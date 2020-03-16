extends State

class_name DummyIdleState

func start() -> void:
	emit_signal("blip", {"type": "change_animation", "animation": "idle"})

func can_see_player() -> bool:
	return true

func process(delta) -> void:
	if can_see_player():
		emit_signal("change_state", "move_closer")
