extends Node2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
	
const SPEED = 100
var velocity = Vector2()
var direction = 1
		
	
func _ready():
	# Get the AnimatedSprite2D node
	animated_sprite = get_node("BulletAnimation")
	animated_sprite.play("Shot")
	
func set_fireball_direction(dir):
	direction = dir
	if dir == -1:
		$BulletAnimation.flip_h = true

func _process(delta):
	velocity.x = SPEED * delta * direction
	translate(velocity)


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_area_2d_body_entered(body):
	if "Slime" in body.name:
		body.dead()
	queue_free()
