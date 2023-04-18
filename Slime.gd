extends Node2D

@onready var animated_sprite: AnimatedSprite2D = $SlimeAnimation
@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready():
	animated_sprite = get_node("SlimeAnimation")
	animated_sprite.play("Slime")
	
func _on_area_entered(area):
	audio_player.play()
	animated_sprite = get_node("SlimeAnimation")
	animated_sprite.play("SlimeHit")
	area.get_parent().queue_free()
	$Timer.start()
	
func _on_timer_timeout():
	queue_free()
