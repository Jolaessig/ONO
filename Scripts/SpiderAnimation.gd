extends AnimatedSprite2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	# Get the AnimatedSprite2D node
	animated_sprite = get_node("LavaAnimation")
	animated_sprite.play("Lava")
