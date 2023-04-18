extends Area2D

@onready var animated_sprite: AnimatedSprite2D = $LavaAnimation
@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready():
	# Get the AnimatedSprite2D node
	animated_sprite = get_node("LavaAnimation")
	animated_sprite.play("Lava")

func _on_body_entered(body):
	if body is Player:
		body.ouch(position.x)
		audio_player.play()
		
	$Timer.start()
		
func _on_timer_timeout():
	get_tree().change_scene_to_file("res://Scripts/GameOver.tscn")
