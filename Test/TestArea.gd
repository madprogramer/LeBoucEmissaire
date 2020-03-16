extends Node2D

func game_over() -> void:
	var label = Label.new()
	label.text = "Game Over"
	label.rect_position = Vector2(500, 300)
	for child in get_children():
		child.queue_free()
	add_child(label)

func _ready():
	get_node("RandomLevelGenerator").player = get_node("Player")
	get_node("Player").connect("game_over", self, "game_over")
