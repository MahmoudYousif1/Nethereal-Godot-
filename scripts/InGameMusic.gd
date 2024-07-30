extends AudioStreamPlayer2D

var current_music = null
var menu_music = preload("res://assets/sounds/mp3/Piano Instrumental 8.mp3")

func play_music(music: AudioStream, volume = -23.129):
	if current_music == music:
		return
	current_music = music
	var player = AudioStreamPlayer.new()
	player.stream = music
	player.volume_db = volume
	player.autoplay = true
	add_child(player)
	player.play()

func play_menu_music():
	play_music(menu_music)

func stop_music():
	for player in get_children():
		if player is AudioStreamPlayer:
			player.stop()
			remove_child(player)
			player.queue_free()
	current_music = null
