extends Node2D

# Add a variable to store the sound effect.
var sound_effect: AudioStreamPlayer

# Load the sound effect in _ready().
func _ready():
	sound_effect = AudioStreamPlayer.new()
	var sound = load("res://Assets/Sounds/Death.wav")
	sound_effect.stream = sound
	add_child(sound_effect)

# Play the sound effect and queue_free() when area is entered.
func _on_area_entered(area):
	# Use `yield` to wait for the sound effect to finish playing.
	await sound_effect.get_stream_playback()
	#queue_free()

