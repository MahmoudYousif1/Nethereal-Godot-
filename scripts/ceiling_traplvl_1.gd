extends Node2D





func _on_slam_body_entered(body):
	if body.is_in_group("player"):
		body.take_damage(50)
		var knockback_direction = (body.global_position - global_position).normalized()
		body.knockback(knockback_direction, 1500)
