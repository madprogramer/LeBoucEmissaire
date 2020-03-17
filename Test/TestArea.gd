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

func _process(delta):
	#if Input.is_key_pressed(KEY_R) or Input.is_key_pressed(KEY_O):
	if Input.is_action_just_pressed("retry"):
		#print("heyo")
		get_tree().reload_current_scene()