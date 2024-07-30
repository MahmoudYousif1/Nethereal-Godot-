extends Node2D

@onready var animation_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player.play("fade_in")

	


func _on_killzone_body_entered(_body):
	animation_player.play_backwards("fade_in")
	await animation_player.animation_finished
	get_tree().reload_current_scene()
