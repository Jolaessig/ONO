extends CharacterBody2D
class_name Player

const SPEED = 120.0
const JUMP_VELOCITY = -320.0
const FRICTION_FORCE = 100.0

const ANIM_IDLE = "idle"
const ANIM_RUN = "run"
const ANIM_JUMP = "jump"

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_jumping = false
var is_on_ground = false

var coins = 0


@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var jumpSound = $Jump
@onready var Global = get_node("res://Global.gd")

func _physics_process(delta: float) -> void:
	
	
	if not is_on_ground:
		velocity.y += gravity * delta
		animated_sprite.animation = ANIM_JUMP
	else:
		if velocity.x == 0:
			animated_sprite.animation = ANIM_IDLE
		elif velocity.x > 0:
			animated_sprite.animation = ANIM_RUN
			animated_sprite.flip_h = false
			$AnimatedSprite2D.play("run")
		elif velocity.x < 0:
			animated_sprite.animation = ANIM_RUN
			animated_sprite.flip_h = true
			$AnimatedSprite2D.play("run")
			
	var direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	if direction != 0:
		velocity.x = direction * SPEED
		animated_sprite.flip_h = direction < 0
	else:
		if is_on_ground:
			var friction_force = -velocity.x * FRICTION_FORCE
			velocity.x = move_toward(velocity.x, 0, abs(friction_force) * delta)
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED * delta)
			
	if Input.is_action_just_pressed("ui_accept") and is_on_ground:
		velocity.y = JUMP_VELOCITY
		is_jumping = true
		jumpSound.play()
		
		
	move_and_slide()
	
	is_on_ground = is_on_floor()
	
	
func add_coin():
	coins = coins + 1
	
func ouch(enemyposx: float):
	set_modulate(Color(1,0.3,0.3,1))
	velocity.y = JUMP_VELOCITY * 0.7
	
	
	
	$Timer.start()
	
	Input.action_release("ui_left")
	Input.action_release("ui_right")
	
func _on_timer_timeout():
	set_modulate(Color(1,1,1,1))
	#NOT WORKING CODE
	
func take_damage(amount):
	Global.lives -= amount
	if Global.lives <= 0:
		print("Condition is true")# handle player/enemy death
	else:
		# handle player/enemy damage without death
		emit_signal("hit")
	


