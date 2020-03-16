extends State

class_name DummyIdleState

func start() -> void:
	.start()

func can_see_player() -> bool:
	return true

func process(delta) -> void:
	if can_see_player():
		emit_signal("change_state", "move_closer")
