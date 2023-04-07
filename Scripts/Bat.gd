extends Node2D

const SPEED = 100
var velocity = Vector2.ZERO

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	# Get the AnimatedSprite2D node
	animated_sprite = get_node("BatAnimation")
	animated_sprite.play("Bat")

func _physics_process(delta):
	# Calculate the direction the enemy should move
	var direction = Vector2.RIGHT.rotated(rotation)
	velocity = direction * SPEED
	
	
	# Set the animation flip_h property based on the direction of movement
	if velocity.x < 0:
		animated_sprite.flip_h = true
	elif velocity.x > 0:
		animated_sprite.flip_h = false
