extends Node2D

@onready var animation_player = $AnimationPlayer
@onready var menu = $Node2D/Menu
@onready var chapter_2 = $Node2D/Chapter2
@onready var chapter_1 = $Node2D/Chapter1
@onready var click_sound = $Node2D/Chapter1/clickSound

# Called when the node enters the scene tree for the first time.
func _ready():
	InGameMusic.play_menu_music()
	animation_player.play("fade_in")
	await animation_player.animation_finished
	animation_player.play("chapter1fade")
	chapter_2.visible = false



func _on_menu_pressed():
	animation_player.play_backwards("fade_in")
	await animation_player.animation_finished
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")




func _on_normal_tutoral_pressed():
	click_sound.play()
	animation_player.play_backwards("fade_in")
	await animation_player.animation_finished
	get_tree().change_scene_to_file("res://scenes/loading_screenChapter1.tscn")




func _on_advanced_tutorial_pressed():
	animation_player.play_backwards("fade_in")
	await animation_player.animation_finished
	get_tree().change_scene_to_file("res://scenes/loading_screenChapter2.tscn")



func _on_right_pressed():
	animation_player.play_backwards("chapter1fade")
	await animation_player.animation_finished
	animation_player.play("chapter2fade")
	chapter_2.visible = true
	chapter_1.visible = false



func _on_chapter_2_left_pressed():
	animation_player.play_backwards("chapter2fade")
	await animation_player.animation_finished
	animation_player.play("chapter1fade")
	chapter_1.visible = true
	chapter_2.visible = false
