extends Node2D

@onready var animation_player = $AnimationPlayer

func _ready():
	animation_player.play("fade_inComplete")
	InGameMusic.play_menu_music()

func _on_replay_pressed():
	animation_player.play_backwards("fade_inComplete")
	await animation_player.animation_finished
	get_tree().change_scene_to_file("res://scenes/advanced_tutorial.tscn")

func _on_button_2_pressed():
	animation_player.play_backwards("fade_inComplete")
	await animation_player.animation_finished
	get_tree().change_scene_to_file("res://scenes/choose_tutorial.tscn")

