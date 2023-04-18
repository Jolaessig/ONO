extends Node2D

@onready var animated_sprite: AnimatedSprite2D = $BatAnimation
@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready():
	animated_sprite = get_node("BatAnimation")
	animated_sprite.play("Bat")
	
func _on_area_entered(area):
	animated_sprite = get_node("BatAnimation")
	animated_sprite.play("BatHit")
	audio_player.play()
	area.get_parent().queue_free()
	$Timer.start()
	
func _on_timer_timeout():
	queue_free()




