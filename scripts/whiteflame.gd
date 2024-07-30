extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		Checkpoint.last_position = global_position
