extends CharacterBody2D
class_name Player

const SPEED = 120.0
const JUMP_VELOCITY = -320.0
const RUNNING_JUMP_VELOCITY = -250
const FRICTION_FORCE = 100.0
const RUNNING_TIME_REQUIRED = 0.3

const ANIM_IDLE = "idle"
const ANIM_RUN = "run"
const ANIM_JUMP = "jump"
const ANIM_SHOOT = "shooting"

const FIREBALL = preload("res://Scripts/Bullet.tscn")

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_jumping = false
var is_on_ground = false
var running_time = 0.0
var can_run_jump = false

var shotCount = 0
var coins = 0
var hitCount = 0
var is_invincible = false


@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var jumpSound = $Jump
@onready var bulletSound = $Bullet
@onready var emptySound = $Empty
@onready var hitSound = $Hit

@onready var bullet = preload("res://Scripts/Bullet.tscn")

var b: Node2D

func _ready() -> void:

	Input.set_mouse_mode( Input.MOUSE_MODE_HIDDEN)

func _physics_process(delta: float) -> void:

	var speed = SPEED
	var jump_velocity = JUMP_VELOCITY
	
	shoot()
	
	
	if Input.is_action_pressed("ui_x") and is_on_ground and can_run_jump:
		speed *= 1.5
		jump_velocity = RUNNING_JUMP_VELOCITY
		
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
			if sign($Marker2D.position.x) == -1:
				$Marker2D.position.x *= -1
		elif velocity.x < 0:
			animated_sprite.animation = ANIM_RUN
			animated_sprite.flip_h = true
			$AnimatedSprite2D.play("run")
			if sign($Marker2D.position.x) == 1:
				$Marker2D.position.x *= -1
			
		if Input.is_action_pressed("ui_x") and is_on_ground:
			running_time += delta
			if running_time >= RUNNING_TIME_REQUIRED:
				can_run_jump = true
		else:
			running_time = 0.0
			can_run_jump = false
			
	var direction = Input.get_action_strength("right") - Input.get_action_strength("left")
	if direction != 0:
		velocity.x = direction * speed
		animated_sprite.flip_h = direction < 0
	else:
		if is_on_ground:
			var friction_force = -velocity.x * FRICTION_FORCE
			velocity.x = move_toward(velocity.x, 0, abs(friction_force) * delta)
		else:
			velocity.x = move_toward(velocity.x, 0, speed * delta)
			
	if Input.is_action_just_pressed("jump_button") and is_on_ground:
		if can_run_jump:
			velocity.y = jump_velocity * 1.5
		else:
			velocity.y = jump_velocity
		is_jumping = true
		jumpSound.play()
		
		
	if Input.is_action_pressed("shoot"):
		$AnimatedSprite2D.play("shots")
		
		
	move_and_slide()
	
	is_on_ground = is_on_floor()
	
			
func add_coin():
	coins = coins + 1
	
func shoot() -> void:
	if Input.is_action_just_pressed("shoot") and shotCount < 3:
		b = bullet.instantiate()
		bulletSound.play()
		
		if sign($Marker2D.position.x) == 1:
			b.set_fireball_direction(1)
		else:
			b.set_fireball_direction(-1)
			
		get_parent().add_child(b)
		if $AnimatedSprite2D.scale.x > 0:
			# character is facing right, so shoot to the right
			b.global_position = $Marker2D.global_position
		elif $AnimatedSprite2D.scale.x < 0:
			# character is facing left, so shoot to the left
			b.global_position = $Marker2D.global_position + Vector2.LEFT * b.get_node("CollisionShape2D").shape.extents.x * 2
		
		# Increase the shot counter
		shotCount += 1

	
func ouch(_enemyposx: float):
	if is_invincible:
		return
	
	is_invincible = true
	hitSound.play()
	set_modulate(Color(1,0.3,0.3,1))
	velocity.y = JUMP_VELOCITY * 0.9
	
	hitCount += 1
	
	if hitCount >= 3:
		$Timer2.start()
	else:
		$Timer.start()
		
	$InvincibilityTimer.start()
	
func _on_timer_timeout():
	set_modulate(Color(1,1,1,1))
	
func _on_timer_2_timeout():
	set_modulate(Color(1,1,1,1))
	get_tree().change_scene_to_file("res://Scripts/GameOver.tscn")


func _on_invincibility_timer_timeout():
	is_invincible = false
	set_modulate(Color(1, 1, 1, 1))
