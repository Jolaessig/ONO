extends Area2D

@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer

func _on_enemy_body_entered(body):
	if body is Player:
		body.ouch(position.x)
		audio_player.play()
			#get_tree().reload_current_scene()


