extends Node2D
@onready var timer = $Timer

func _on_area_2d_body_entered(_body):
	print("You died")
	timer.start()

func _on_timer_timeout():
	get_tree().reload_current_scene()
