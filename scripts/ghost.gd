extends AnimatedSprite2D

const FADE_TIME = 0.5
var fade_timer = FADE_TIME

func _ready():
	set_process(false)  # Disable process by default

func start_fade():
	fade_timer = FADE_TIME
	set_process(true)

func _process(delta):
	fade_timer -= delta
	modulate.a = fade_timer / FADE_TIME
	if fade_timer <= 0:
		queue_free()
