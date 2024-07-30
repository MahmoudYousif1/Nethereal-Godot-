extends Sprite2D

func _ready():
	ghosting()

func set_property(tx_pos, tx_scale):
	position = tx_pos
	scale = tx_scale

func ghosting():
	var fade = get_tree().create_tween()
	fade.tween_property(self, "self_modulate", Color(1, 1, 1, 0), 0.75)
	await fade.finished
	queue_free()
