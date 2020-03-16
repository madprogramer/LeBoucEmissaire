extends Node

class_name State

signal blip(args)
signal change_state(new_state)

var variables := {}

var is_active: bool = false

func start() -> void:
	is_active = true
	pass

func process(delta) -> void:
	pass

func end() -> void:
	is_active = false
	pass

func update_variable(variable_name: String, value) -> void:
	variables[variable_name] = value
