extends Area2D

signal coin_collected

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready():
	# Get the AnimatedSprite2D node
	animated_sprite = get_node("CoinAnimation")
	animated_sprite.play("Coins")
	

func _on_body_entered(body):
	# Free the coin node
	$AnimationPlayer.play("bounce")
	emit_signal("coin_collected")
	audio_player.play()
	
func _on_animation_player_animation_finished(anim_name):
	queue_free()
