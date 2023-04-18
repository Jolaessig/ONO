extends CharacterBody2D
class_name Skeleton

var direction = Vector2.RIGHT


@onready var LedgeCheckRight: = $LedgeCheckRight
@onready var LedgeCheckLeft: = $LedgeCheckLeft

@onready var animated_sprite: AnimatedSprite2D = $Skeleton


func _ready():
	# Get the AnimatedSprite2D node
	animated_sprite = get_node("Skeleton")
	animated_sprite.play("Walking")
	

func _physics_process(_delta):
	var found_wall = is_on_wall()
	var found_ledge = not LedgeCheckRight.is_colliding() or not LedgeCheckLeft.is_colliding()
	
	if found_wall or found_ledge:
		direction *= -1
		
	animated_sprite.flip_h = direction.x > 0
		
	velocity = direction * 25
	move_and_slide()
	
	#NOT WORKING CODE:
	
func _on_body_entered(_body):
	var amount = 1 # or whatever amount of damage you want to do
	Global.lives -= amount
	if Global.lives <= 0:
		print("Condition is true") # handle player/enemy death
	else:
		# handle player/enemy damage without death
		emit_signal("hit")

