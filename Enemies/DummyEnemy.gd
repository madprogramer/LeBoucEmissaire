extends KinematicBody2D

class_name DummyEnemy

var current_animation = "idle"

func change_animation(new_animation: String):
	if new_animation == current_animation:
		return
	
	get_node("AnimatedSprite").animation = new_animation
	current_animation = new_animation

var states := {
	"attack": get_node("States/DummyAttackState"),
	"idle": get_node("States/DummyIdleState"),
	"move_closer": get_node("States/DummyMoveCloserState")
}

var init_state := "idle"

var variables := {}

func set_player(player: Player) -> void:
	variables["player"] = player
	get_node("EnemyStateMachine").update_variable("player", player)

func move_closer() -> void:
	if variables.has("player") == false:
		return
	
	var player = variables["player"]
	
	var aim_vec = player.global_position - global_position
	aim_vec.y = 0
	aim_vec = aim_vec.normalized()
	
	move_and_collide(aim_vec * variables["speed"])

func attack(attack_type: String) -> void:
	pass

func _process(delta):
	if get_node("EnemyStateMachine").is_active():
		get_node("EnemyStateMachine").process(delta)

func _ready():
	add_to_group("Enemies")
	get_node("EnemyStateMachine").connect("change_animation", self, "change_animation")
	get_node("EnemyStateMachine").connect("move_closer", self, "move_closer")
	get_node("EnemyStateMachine").connect("attack", self, "attack")
	get_node("EnemyStateMachine").init(states, init_state, variables)
	get_node("EnemyStateMachine").update_variable("body", self)
