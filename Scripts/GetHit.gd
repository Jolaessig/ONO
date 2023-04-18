extends Node2D

@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer

var new_position = position

func _on_area_entered(scene):
	scene.get_parent().queue_free()
	audio_player.play()
	set_modulate(Color(1,0.3,0.3,1))
	$Timer.start()
	
func _on_timer_timeout():
	queue_free()
