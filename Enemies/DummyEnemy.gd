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
	print_debug("move_closer")

func attack(attack_type: String) -> void:
	print_debug(attack_type)

func _process(delta):
	if get_node("EnemyStateMachine").is_active():
		get_node("EnemyStateMachine").process(delta)

func _ready():
	add_to_group("Enemies")
	get_node("EnemyStateMachine").connect("change_animation", self, "change_animation")
	get_node("EnemyStateMachine").connect("move_closer", self, "move_closer")
	get_node("EnemyStateMachine").connect("attack", self, "attack")
	get_node("EnemyStateMachine").init(states, init_state, variables)
