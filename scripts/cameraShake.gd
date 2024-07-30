extends Camera2D

var shake_amount = 0.0
var shake_decay = 0.05

func _process(_delta):
	if shake_amount > 0:
		shake_amount -= shake_decay
		if shake_amount < 0:
			shake_amount = 0
		# Randomly offset the camera within the shake amount range
		offset = Vector2(randf_range(-shake_amount, shake_amount), randf_range(-shake_amount, shake_amount))
	else:
		offset = Vector2.ZERO

func start_shake(amount):
	shake_amount = amount
