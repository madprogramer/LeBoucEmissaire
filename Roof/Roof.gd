extends StaticBody2D

class_name Roof

func get_size() -> Vector2:
	return get_node("CollisionShape2D").shape.extents
