extends Control

@onready var animation_player = $AnimationPlayer

func _ready():
	InGameMusic.stop_music()
	get_tree().paused = false
	self.hide()
	set_process_input(true)
	

func resume():
	get_tree().paused = false
	animation_player.play_backwards("blur")
	self.hide()

func pause():
	get_tree().paused = true
	animation_player.play("blur")
	InGameMusic.play_menu_music()
	self.show()

func _input(event):
	if event.is_action_pressed("pause"):
		if !get_tree().paused:
			pause()
		else:
			resume()

func _on_resume_pressed():
	resume()
	

func _on_menu_pressed():
	animation_player.play_backwards("blur")
	await animation_player.animation_finished
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")



func _on_options_pressed():
	animation_player.play_backwards("blur")
	await animation_player.animation_finished
	get_tree().change_scene_to_file("res://scenes/options_menu.tscn")
