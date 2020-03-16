extends Node

class_name StateMachine

var states := {}

var current_state: String = ""

var variables := {}

func change_state(new_state: String) -> void:
	if current_state == new_state:
		return
	
	states[current_state].end()
	current_state = new_state
	states[current_state].start()

func blip(args: Dictionary) -> void:
	pass

func update_variable(variable: String, value) -> void:
	variables[variable] = value
	for state in states:
		states[state].update_variable(variable, value)

func process(delta):
	if states[current_state] != null and states[current_state].is_active:
		states[current_state].process(delta)

var active: bool = false

func init(states: Dictionary, init_state: String, variables: Dictionary) -> void:
	self.states = states
	self.current_state = init_state
	self.states[current_state].start()
	
	for state in states:
		states[state].connect("change_state", self, "change_state")
		states[state].connect("blip", self, "blip")
	
	for variable in variables:
		update_variable(variable, variables[variable])
	
	active = true

func is_active():
	if active and states[current_state] != null and states[current_state].is_active:
		return true
	
	return false
