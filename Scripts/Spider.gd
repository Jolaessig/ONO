extends Node2D

@onready var animated_sprite: AnimatedSprite2D = $SpiderAnimation
@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready():
	animated_sprite = get_node("SpiderAnimation")
	animated_sprite.play("Spider")


func _on_area_entered(area):
	area.get_parent().queue_free()
	audio_player.play()
	animated_sprite = get_node("SpiderAnimation")
	animated_sprite.play("SpiderHit")
	$Timer.start()

	
func _on_timer_timeout(area):
	area.queue_free()
