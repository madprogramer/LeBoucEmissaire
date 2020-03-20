extends Node2D

var isGameOver = false

func game_over() -> void:
	isGameOver = true
	var ourFont = DynamicFont.new()
	ourFont.font_data = load("res://CloisterBlack.ttf")
	ourFont.size = 36
	ourFont.outline_size = 3
	ourFont.outline_color = Color( 0, 0, 0, 1 )
	ourFont.use_filter = true
	
	var label = Label.new()
	label.add_font_override("font", ourFont)
	#label.add_color_override("font_color", Color.white)
	
	var finalScore = get_node("CanvasLayer").furthest
	
	var quotes = [
"""
Fear cuts deeper than swords.
\n― George R.R. Martin""",
"""
Nothing in life is to be feared, it is only to be understood.\nNow is the time to understand more, so that we may fear less. 
\n― Marie Curie""",
"""
I learned that courage was not the absence of fear,\nbut the triumph over it. The brave man is not he who\ndoes not feel afraid, but he who conquers that fear.
\n― Nelson Mandela""",
"""
A man that flies from his fear may find that\nhe has only taken a short cut to meet it.
\n― J.R.R. Tolkien""",
"""
The only thing we have to fear is fear itself.
\n― Franklin D. Roosevelt""",
"""
Without fear there cannot be courage.
\n― Christopher Paolini""",
"""
He who fears he shall suffer, already suffers what he fears.
\n― Michel de Montaigne""",
"""
Of all the liars in the world,\nsometimes the worst are our own fears.
\n― Rudyard Kipling""",
"""
The cause of fear is ignorance.
\n― Lucius Annaeus Seneca""",
"""
Here is the world. Beautiful and terrible things will happen.\nDon't be afraid.
\n― Frederick Buechner""",
"""
Find out what a person fears most and that is where\nhe will develop next.
\n― Carl Gustav Jung"""
]
	
	var choice = quotes[randi()%11]
	#var choice = quotes[10]
	#print(choice)

	
	#print(furthest)
	label.text = "Game Over!                                        Click to retry\nDistance: " + str(floor(finalScore)) + "\n" + choice
	label.rect_position = Vector2(50, 100)
	
	#BG
	var BG = ColorRect.new()
	BG.color = Color(0,0,0,1)
	BG.rect_position = Vector2(0,0)
	BG.rect_size = Vector2(1e4,1e4)
		
	for child in get_children():
		child.queue_free()
	#draw_rect(Rect2(64,64,64,64),Color(0,0,0,1))
	
	#add_child(BG)
	add_child(BG)
	add_child(label)
	
	print(BG)

func _ready():
	get_node("RandomLevelGenerator").player = get_node("Player")
	get_node("Player").connect("game_over", self, "game_over")
	randomize()
	isGameOver = false

func _process(delta):
	#if Input.is_key_pressed(KEY_R) or Input.is_key_pressed(KEY_O):
	if Input.is_action_just_pressed("retry"):
		#print("heyo")
		get_tree().reload_current_scene()
	elif isGameOver and Input.is_action_just_pressed("conditional_retry"):
		get_tree().reload_current_scene()
