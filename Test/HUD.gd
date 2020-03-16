extends CanvasLayer
var time_start
var time_now
var time

signal start_game

func update_score(score):
	$ScoreLabel.text = str(score)

func _on_pause():
	$in_game_menu.hide();
	


func _ready():
	time_start = OS.get_unix_time()
	set_process(true)
	
	var menu_button = find_node("menu_button")
	menu_button = menu_button.connect("pressed",self ,"_on_pause")
	
# warning-ignore:unused_argument
func _process(delta):
	time_now = OS.get_unix_time()
	time = time_now - time_start
	update_score(time*10)
	
#_on_pause()
	
