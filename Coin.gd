extends Area2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	# Get the AnimatedSprite2D node
	animated_sprite = get_node("CoinAnimation")
	animated_sprite.play("Coins")



func _on_body_entered(body):
	queue_free()

