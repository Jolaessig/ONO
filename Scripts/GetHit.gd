extends Node2D

@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer

func _on_area_entered(scene):
	audio_player.play()
	scene.get_parent().queue_free()
	set_modulate(Color(1,0.3,0.3,1))
	$Timer.start()
	
func _on_timer_timeout():
	queue_free()
