extends Node2D

@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer

func _on_area_entered(_area):
	audio_player.play()
	
	$Timer.start()
	
func _on_timer_timeout():
	queue_free()

