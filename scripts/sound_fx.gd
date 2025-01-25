extends Node

@onready var sound_players = get_children()

var sounds = {
	#"" : load(),
	#"" : load(),
	#"" : load()
}


func play(sound_name):
	var sound_to_play =sounds[sound_name]
	for sound_player in sound_players:
		if !sound_player.playing:
			sound_player.stream = sound_to_play
			sound_player.play()
			return
