extends Node2D

@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer

func _on_area_entered(area):
	audio_player.play()
	set_modulate(Color(1,0.3,0.3,1))
	area.get_parent().queue_free()
	$Timer.start()
	
	
func _on_timer_timeout():
	queue_free()

