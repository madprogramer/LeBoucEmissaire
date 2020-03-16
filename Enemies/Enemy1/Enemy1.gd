extends DummyEnemy

# Attack: melee

class_name Enemy1

func _ready():
	states = {
		"attack": get_node("States/Enemy1AttackState"),
		"idle": get_node("States/Enemy1IdleState"),
		"move_closer": get_node("States/Enemy1MoveCloserState")
	}
	
	init_state = "idle"
	
	._ready()
	
	variables["speed"] = 0.25
	get_node("EnemyStateMachine").update_variable("move_closer_range", 300.0)
