extends Node2D

const SPEED = 300
var direction = 1

@onready var ray_castright = $RayCastright
@onready var ray_castleft = $RayCastleft
@onready var animated_sprite_2d = $AnimatedSprite2D

func _process(delta):
	if ray_castright.is_colliding():
		direction = -1
		animated_sprite_2d.flip_h = true
	if ray_castleft.is_colliding():
		direction = 1
		animated_sprite_2d.flip_h = false
	position.x += direction * SPEED * delta



func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		body.take_damage(15)
		var knockback_direction = (body.global_position - global_position).normalized()
		body.knockback(knockback_direction, 400)
