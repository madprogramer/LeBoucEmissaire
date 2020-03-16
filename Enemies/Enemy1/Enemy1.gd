extends DummyEnemy

# Attack: melee

class_name Enemy1

func move_closer() -> void:
	if variables["player"] == null:
		return
	
	var player = variables["player"]
	
	var aim_vec = player.global_position - global_position
	aim_vec.y = 0
	aim_vec = aim_vec.normalized()
	
	move_and_collide(aim_vec * variables["speed"])

func _ready():
	._ready()
	variables["speed"] = 0.25
	get_node("EnemyStateMachine").update_variable("move_closer_range", 300.0)
