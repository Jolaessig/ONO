extends Node2D

const SPEED = 100
var velocity = Vector2.ZERO

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	# Get the AnimatedSprite2D node
	animated_sprite = get_node("BatAnimation")
	animated_sprite.play("Bat")



