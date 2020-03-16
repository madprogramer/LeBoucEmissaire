extends Node

class_name StateMachine

var states := {}

var current_state: String = ""

func change_state(new_state: String) -> void:
	if current_state == new_state:
		return
	
	states[current_state].end()
	current_state = new_state
	states[current_state].start()

func init(states: Dictionary, init_state: String) -> void:
	self.states = states
	self.current_state = init_state
	self.states[current_state].start()
