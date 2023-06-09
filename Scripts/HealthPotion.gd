extends Area2D

@onready var animated_sprite: AnimatedSprite2D = $HealthPotionAnimation
@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer
		
		
func _ready():
	# Get the AnimatedSprite2D node
	animated_sprite = get_node("HealthPotionAnimation")
	animated_sprite.play("HealthPotion")

func _on_body_entered(_body):
	# Free the coin node
	$AnimationPlayer.play("bounce")
	audio_player.play()
	
func _on_animation_player_animation_finished(_anim_name):
	queue_free()

