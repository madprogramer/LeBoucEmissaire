extends CanvasLayer
var time_start
var time_now
var time
var ispause = 1
signal start_game
var score_all = 0

func update_score(score):
	$ScoreLabel.text = str(score)

func menuon():
	score_all += time*10
	ispause = 0
	$menuoff.show()
	$in_game_menu.show()

func menuoff():
	ispause = 1
	$menuoff.hide()
	$in_game_menu.hide()
	
func _ready():
	time_start = OS.get_unix_time()
	set_process(true)
	
	var menuon = find_node("menuon")
	menuon = menuon.connect("pressed",self ,"menuon")
	
	var menuoff = find_node("menuoff")
	menuoff = menuoff.connect("pressed",self ,"menuoff")
	
	$in_game_menu.hide();
	
# warning-ignore:unused_argument
func _process(delta):
	time_now = OS.get_unix_time()
	time = time_now - time_start
	if(ispause):
		update_score(score_all + time*10)
	else:
		
		time_start = time_now
	
	
