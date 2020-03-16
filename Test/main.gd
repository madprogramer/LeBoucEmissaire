extends Node
var time_start
var time_now
var time


func update_score(score):
	$ScoreLabel.text = str(score)



func _ready():
	time_start = OS.get_unix_time()
	set_process(true)
	
# warning-ignore:unused_argument
func _process(delta):
	time_now = OS.get_unix_time()
	time = time_now - time_start
	
	update_score(time*10)
	
	
	
