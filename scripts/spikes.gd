extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




func _on_spike_attack_body_entered(body):
	if body.is_in_group("player"):
		body.take_damage(25)
		var knockback_direction = (body.global_position - global_position).normalized()
		body.knockback(knockback_direction, 1000)
