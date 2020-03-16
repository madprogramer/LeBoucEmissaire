extends DummyEnemy

# Attack: melee

class_name PlagueDoctor

var current_direction = "right"

func change_direction(new_direction: String) -> void:
	if current_direction == new_direction:
		return
	
	if current_direction == "right":
		get_node("AnimatedSprite").offset.x = -170.0
	
	else:
		get_node("AnimatedSprite").offset.x = 170.0
	
	get_node("AnimatedSprite").flip_h = !get_node("AnimatedSprite").flip_h
	
	current_direction = new_direction

const MULTX := 300.0
const MULTY := 100.0

var last_delta: float = 0.016

func _process(delta):
	last_delta = delta

func move_closer() -> void:
	if variables.has("player") == false:
		return
	
	var player = variables["player"]
	
	var aim_vec = player.global_position - global_position
	aim_vec = aim_vec.normalized()
	aim_vec.x = aim_vec.x * last_delta * MULTX
	aim_vec.y = 0.4 * last_delta * MULTY
	
	move_and_collide(aim_vec * variables["speed"])
	
	if aim_vec.x > 0.0:
		change_direction("right")
	elif aim_vec.x < 0.0:
		change_direction("left")

func _ready():
	states = {
		"attack": get_node("States/PlagueDoctorAttackState"),
		"idle": get_node("States/PlagueDoctorIdleState"),
		"move_closer": get_node("States/PlagueDoctorMoveCloserState")
	}
	
	init_state = "move_closer"
	
	._ready()
	
	variables["speed"] = 1.0
	get_node("EnemyStateMachine").update_variable("move_closer_range", 50.0)
