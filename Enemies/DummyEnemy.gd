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

func _ready():
	get_node("EnemyStateMachine").init(states, init_state, variables)
