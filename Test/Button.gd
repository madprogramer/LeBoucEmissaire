extends Button
var time_start
var time_now
var time

func _ready():
	time_start = OS.get_unix_time()
	set_process(true)
	

	
