extends Node

class_name State

signal blip(args)
signal change_state(new_state)

var variables := {}

func start() -> void:
	pass

func process(delta) -> void:
	pass

func end() -> void:
	pass

func update_variable(variable_name: String, value) -> void:
	variables[variable_name] = value
