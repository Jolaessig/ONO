extends Area2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
		
		
func _ready():
	# Get the AnimatedSprite2D node
	animated_sprite = get_node("HealthPotionAnimation")
	animated_sprite.play("HealthPotion")

func _on_body_entered(body):
		queue_free()

