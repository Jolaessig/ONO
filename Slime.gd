extends Node2D

@onready var animated_sprite: AnimatedSprite2D = $SlimeAnimation

var is_dead = false


func _ready():
	# Get the AnimatedSprite2D node
	animated_sprite = get_node("SlimeAnimation")
	animated_sprite.play("Slime")
