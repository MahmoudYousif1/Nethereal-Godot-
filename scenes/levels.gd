extends Node2D

@onready var button_1 = $level/options/Button1
@onready var button_2 = $level/options/Button2
@onready var timer = $level/options/Timer
@onready var animation_player = $AnimationPlayer

func _ready():
	InGameMusic.play_menu_music()
	animation_player.play("fade_in")


func _on_button_1_pressed():
	animation_player.play("fade_out")
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")



func _on_level_1_pressed():
	animation_player.play("fade_out")
	get_tree().change_scene_to_file("res://scenes/the_red_rift.tscn")
