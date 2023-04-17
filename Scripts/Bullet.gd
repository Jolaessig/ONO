extends Node2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	# Get the AnimatedSprite2D node
	animated_sprite = get_node("BulletAnimation")
	animated_sprite.play("Shot")

func _process(delta):
	position.x += 1


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
