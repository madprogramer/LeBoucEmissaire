extends Node2D

func game_over() -> void:
	var ourFont = DynamicFont.new()
	ourFont.font_data = load("res://CloisterBlack.ttf")
	ourFont.size = 120
	ourFont.outline_size = 5
	ourFont.outline_color = Color( 0, 0, 0, 1 )
	ourFont.use_filter = true
	
	var label = RichTextLabel.new()
	label.add_font_override("font", ourFont)
	label.add_color_override("font_color", Color.white)
	
	var finalScore = get_node("CanvasLayer").furthest
	
	var quotes = [
"""
Fear cuts deeper than swords.
- George R.R. Martin""",
"""
Nothing in life is to be feared, it is only to be understood. Now is the time to understand more, so that we may fear less. 
― Marie Curie""",
"""
I learned that courage was not the absence of fear, but the triumph over it. The brave man is not he who does not feel afraid, but he who conquers that fear.
― Nelson Mandela""",
"""
A man that flies from his fear may find that he has only taken a short cut to meet it.
- J.R.R. Tolkien""",
"""
The only thing we have to fear is fear itself.
― Franklin D. Roosevelt""",
"""
Without fear there cannot be courage.
― Christopher Paolini""",

"He who fears he shall suffer, already suffers what he fears."
― Michel de Montaigne

"Of all the liars in the world, sometimes the worst are our own fears."
― Rudyard Kipling

"The cause of fear is ignorance."
― Lucius Annaeus Seneca

"Here is the world. Beautiful and terrible things will happen. Don't be afraid."
― Frederick Buechner

"Find out what a person fears most and that is where he will develop next."
― Carl Gustav Jung
]

	
	#print(furthest)
	label.text = "Game Over\nDistance:" + str(floor(finalScore))
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