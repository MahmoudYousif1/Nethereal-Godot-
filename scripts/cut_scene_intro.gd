extends Node2D
@onready var animation_player = $AnimationPlayer
@onready var sentence_1_timer = $IntroText/Sentence1Timer
@onready var wait_timer = $IntroText/WaitTimer
@onready var sentence_2_timer = $IntroText/Sentence2Timer
@onready var wait_timer_2 = $IntroText/WaitTimer2
@onready var button = $IntroText/Node2D/Button


# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player.play("button_fade")
	animation_player.play("Sentence1")
	sentence_1_timer.start()

func _on_timer_timeout():
	animation_player.play("Sentence1_fade")
	wait_timer.start()



func _on_wait_timer_timeout():
	animation_player.play("boom")
	sentence_2_timer.start()



func _on_sentence_2_timer_timeout():
	animation_player.play("fade_out_boom")
	wait_timer_2.start()


func _on_wait_timer_2_timeout():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
