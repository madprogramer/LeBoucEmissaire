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

var last_delta: float = 0.016

func _process(delta):
	last_delta = delta

var dx := 0.0
var dy := 0.0

const DXLIM = 0.5
const GRIND = 0.01
const JUMP_LIMIT = 2.0
const FALL_LIMIT = 1000000.0
const GRAVITY = 0.015
const JUMP_BOOST = 1.2
const FALL_BOOST = 0.8

var head_bodies := 0
var toe_bodies := 0

const MULTX := 300.0
const MULTY := 600.0

func head_colliding() -> bool:
	return head_bodies != 0

func toes_colliding() -> bool:
	return toe_bodies != 0

func _on_Head_body_entered(body):
	if body.name != "Player":
		head_bodies += 1


func _on_Head_body_exited(body):
	if body.name != "Player":
		head_bodies -= 1


func _on_Toes_body_entered(body):
	if body.name != "Player":
		toe_bodies += 1


func _on_Toes_body_exited(body):
	if body.name != "Player":
		toe_bodies -= 1

func move_closer() -> void:
	if variables.has("player") == false:
		return
	
	var player = variables["player"]
	
	var aim_vec = player.global_position - global_position
	aim_vec.y = 0.0
	aim_vec = aim_vec.normalized()
	
	var move_vec = aim_vec
	if move_vec.x > 0.0:
		dx += 0.2
	elif move_vec.x < 0.0:
		dx -= 0.2
	
	dx = clamp(dx, -DXLIM, DXLIM)
	
	if dx >= GRIND:
		dx -= GRIND
	elif dx <= -GRIND:
		dx += GRIND
	else:
		dx = 0.0
	
	var is_head_colliding: bool = head_colliding()
	var is_toes_colliding: bool = toes_colliding()
	
	if is_head_colliding:
		dy = FALL_BOOST
	
	elif is_toes_colliding:
		dy = 0.0
		if move_vec.y < 0.0:
			dy = -JUMP_BOOST
	
	else:
		dy = 100 * FALL_BOOST
		dx = 0.0
	
	dy = clamp(dy, -JUMP_LIMIT, FALL_LIMIT)
	
	if dx < 0.0:
		change_direction("left")
	elif dx > 0.0:
		change_direction("right")
	
	move_and_collide(Vector2(dx * last_delta * MULTX, dy * last_delta * MULTY))

func _ready():
	states = {
		"attack": get_node("States/PlagueDoctorAttackState"),
		"idle": get_node("States/PlagueDoctorIdleState"),
		"move_closer": get_node("States/PlagueDoctorMoveCloserState")
	}
	
	init_state = "idle"
	
	._ready()
	
	variables["speed"] = 1.0
	get_node("EnemyStateMachine").update_variable("move_closer_range", 50.0)
	get_node("EnemyStateMachine").update_variable("see_range", 300.0)
