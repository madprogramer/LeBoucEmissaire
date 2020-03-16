extends StateMachine

class_name EnemyStateMachine

signal change_animation(new_animation)
signal move_closer
signal attack(attack_type)

func blip(args: Dictionary) -> void:
	if args.type == "change_animation":
		emit_signal("change_animation", args.animation)
	
	if args.type == "move_closer":
		emit_signal("move_closer")
	
	if args.type == "attack":
		emit_signal("attack", args.attack)
