extends Panel

var time: float = 0.0
var minute: int  = 0
var seconds: int = 0
@onready var minutes1 = $minutes
@onready var seconds1 = $seconds

func _process(delta) -> void:
	time += delta
	seconds = fmod(time, 60)
	minute = fmod(time, 3600) / 60
	minutes1.text = "%02d:" % minute
	seconds1.text = "%02d" % seconds

func stop():
	set_process(false)

func get_timeFormat(time1) -> String:
	time1 = "%02d : %02d" % [minute, seconds]
	Global.completion_time = time1
	return time1
