extends Node2D

@onready var animation_player = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	InGameMusic.play_menu_music()
	animation_player.play("fade")

func _on_move_text_body_entered(_body):
	animation_player.play("movefade")



func _on_move_text_body_exited(_body):
	animation_player.play_backwards("movefade")



func _on_completed_body_entered(_body):
	animation_player.play_backwards("fade")
	await animation_player.animation_finished
	get_tree().change_scene_to_file("res://scenes/tutorial_complete.tscn")



func _on_killzone_body_entered(_body):
	animation_player.play_backwards("fade")
	await animation_player.animation_finished
	get_tree().reload_current_scene()


