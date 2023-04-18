extends Area2D

signal coin_collected

@onready var animated_sprite: AnimatedSprite2D = $CoinAnimation
@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var shape_to_delete := $CollisionShape2D

func _ready():
	# Get the AnimatedSprite2D node
	animated_sprite = get_node("CoinAnimation")
	animated_sprite.play("Coins")
	

func _on_body_entered(_body):
	# Free the coin node
	$AnimationPlayer.play("bounce")
	emit_signal("coin_collected")
	audio_player.play()
	shape_to_delete.queue_free()
	
func _on_animation_player_animation_finished(_anim_name):
	queue_free()
