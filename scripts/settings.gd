extends Node2D

@onready var animation_player = $AnimationPlayer
@onready var timer = $Node2D/Timer
@onready var menu = $Node2D/menu
@onready var clicking_button_sound = $clickingButtonSound
@onready var toggle_sound = $toggleSound

func _ready():
	InGameMusic.play_menu_music()
	animation_player.play("fade_in")



func _on_menu_pressed():
	animation_player.play("fade_out")
	clicking_button_sound.play()
	timer.start()


func _on_timer_timeout():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_system_mouse_entered():
	toggle_sound.play()
	get_tree().reload_current_scene()


func _on_system_pressed():
	clicking_button_sound.play()


func _on_controls_mouse_entered():
	toggle_sound.play()



func _on_controls_pressed():
	clicking_button_sound.play()
	


func _on_audio_mouse_entered():
	toggle_sound.play()


func _on_audio_pressed():
	clicking_button_sound.play()
	get_tree().paused = false


func _on_menu_mouse_entered():
	toggle_sound.play()

