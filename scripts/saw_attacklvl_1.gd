extends Node2D

@onready var collision_shape = $sawattack/CollisionShape2D
@onready var saw_sound = $sawSound
@onready var cpu_particles_2d = $sawattack/CPUParticles2D
@onready var hit_sound = $hitSound
# Called when the node enters the scene tree for the first time.
func _ready():
	saw_sound.play()

func _on_sawattack_body_entered(body):
	if body.is_in_group("player"):
		body.take_damage(30)
		cpu_particles_2d.emitting = true
		hit_sound.play()
		var knockback_direction = (body.global_position - global_position).normalized()
		body.knockback(knockback_direction, 2000)
