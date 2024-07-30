extends Node2D
@onready var animation_player = $AnimationPlayer
@onready var clicking_button_sound = $Node2D/clickingButtonSound
@onready var toggle_sound = $Node2D/ToggleSound
@onready var waiting_1 = $waiting1

func _ready():
	InGameMusic.play_menu_music()
	animation_player.play("fade_in")
	

func _on_tutorial_button_pressed():
	animation_player.play("fade_out")
	await animation_player.animation_finished
	get_tree().change_scene_to_file("res://scenes/choose_tutorial.tscn")
	
	


func _on_quit_button_pressed():
	animation_player.play("fade_out")
	await animation_player.animation_finished
	get_tree().quit()

func on_options_pressed(_animation):
		pass
		

func _on_options_button_pressed():
	animation_player.play("fade_out")


func _on_levels_button_pressed():
	animation_player.play("fade_out")
	await animation_player.animation_finished
	get_tree().change_scene_to_file("res://scenes/advanced_tutorial.tscn")


func _on_tutorial_button_mouse_entered():
	toggle_sound.play()


func _on_levels_button_mouse_entered():
	toggle_sound.play()


func _on_quit_button_mouse_entered():
	toggle_sound.play()


func _on_options_button_mouse_entered():
	toggle_sound.play()
